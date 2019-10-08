module ApplicationConcern
	extend ActiveSupport::Concern

	### retruns model instance based on controller name if exists
	### else nil
	def model_exist?
		Module.const_get(controller_name.classify)
	rescue NameError
		return nil
	end

	def curr_controller_has_model?
		@model.blank? ? false : true
	end

	def is_subsection_of(parent_controller: nil)
	  	@render_command_prepend = parent_controller.nil? ? "" : "#{parent_controller}/#{controller_name}/"
  	end

  	def user_logged_and_model_exist?
  		return @user_logged_and_model_exist = user_signed_in?&&model_exist?
  	end

  	def task_banned_for_user?
  		@task_banned_for_user = (_ban_admin_tasks! == true)&&(!current_user.is_admin)
  	end

  	def generate_form_url
  		url = case action_name
  		when 'new', 'create'
  			'new'
  		when 'edit', 'update'
  			'edit'
  		end
  		@form_url = { url: url }
 	end

 	def watch_if_allowed
 		if !@task_banned_for_user
 			yield
 		else
	      	redirect_to(action: :index)
	      	flash[:not_allowed] = t('actions.not_allowed')
	    end
 	end

 	def custom_render(a_name)
 		render "#{@render_command_prepend}#{a_name.to_s}"
 	end

 	def permitted_params
 		params[controller_name.underscore.singularize.to_sym].permit(_allowed_params)
 	end

	def build_if_empty(*assocs)

		if action_name == "new" || action_name == "create"

			assocs.each do |a, opts|
				assoc_var_name = "@#{a.to_s.singularize}"
				build_command = a.to_s.is_singular? ? "build_#{a.to_s}" : "build"

				if (a.to_s.is_singular?)
					if @record.send(a).nil?
						# association does not exist
						if @record.has_attribute? "#{a.to_s}_id"
							# but parent model have foreign key field for assoc
							instance_variable_set(assoc_var_name, @record.send(build_command))
							#set single record instance variable and also build parent object assocition
						end
					else
						instance_variable_set(assoc_var_name, @record.send(a))
					end
				else
					# if associated has not been build yet
					if (iv = @record.send(a)).length == 0
						instance_variable_set(assoc_var_name, iv.send(build_command))
					else
						# if has been built
						# if empty field leave after reload for example after failed association
						# due to reject_if option of accept_nested_attributes_for
						# create and append one to associations (record with empty id)
						if !iv.collect(&:id).any? { |a| a.nil? }
							iv << a.to_s.singularize.classify.constantize.send(:new)
						end
						instance_variable_set(assoc_var_name, iv)
					end
				end
			end

		elsif action_name == "edit" || action_name == "update"

			assocs.each do |a, opts|
				assoc_var_name = "@#{a.to_s.singularize}"
				if a.to_s.is_singular?
					if @record.send(a).blank?
						@record.send("build_#{a.to_s}")
					end
					instance_variable_set(assoc_var_name, @record.send(a))
				else
					any_builded_assoc = @record.send(a).map { |r| r.id.blank? } .any?
					if !any_builded_assoc
						@record.send(a).send(:build)
					else
						instance_variable_set(assoc_var_name, @record.send(a))
					end
					#instance_variable_set(assoc_var_name, @record.send(a))
				end
			end

		end
	end

	def apicall_render(type_of_assoc)
		render("layouts/shared/new_edit_form/#{type_of_assoc.to_s}")
	end

 	def will_paginate *pars
 		params[:will_paginate] = pars

 		pars.each do |par|
 			ids_arr = []
 			is_new = (action_name=='new'||action_name=='create') ? true : false

 			if params.deep_has_key?(:q, "#{par.to_s.singularize}_filter".to_sym)
                if (p = params[:q]["#{par.to_s.singularize}_filter"]).instance_of?(String)
			         ids_arr.push(p.to_i)
                elsif p.instance_of?(Array)
                    tmp_arr = p.map { |x| x.to_i }
                    tmp_arr2 = tmp_arr - ids_arr&tmp_arr
                    ids_arr.concat(tmp_arr2)
                end

    		end

    		if is_new&&params.has_key?(:apply_last_select)
    			ids_from_repeater_mem = @MEM.send("last_#{par}_#{controller_name.singularize.underscore}")
	    		ids_from_repeater_mem = [] if ids_from_repeater_mem.nil?
	    		if !par.to_s.is_singular?
	    			ids_arr = ids_arr|ids_from_repeater_mem
	    		else
	    			ids_arr.push(ids_from_repeater_mem) if !ids_from_repeater_mem.blank?
	    		end
	    	end

    		cnt = "#{controller_name.singularize.underscore}".to_sym

    		if !is_new&&par.to_s.is_singular?
    			assoc = "#{par.to_s}_id"
    			id = params[cnt][assoc.to_sym] if params.deep_has_key?(cnt, assoc)
    			ids_arr.push(id) if !id.blank?
    		elsif !is_new&&!par.to_s.is_singular?
    			assoc = "#{par.to_s.singularize}_ids".to_sym
    			ids = params[cnt][assoc] if params.deep_has_key?(cnt, assoc)
    			ids_arr.push(ids.reject(&:empty?)) if !ids.nil?
    		end

    		if !par.to_s.is_singular?
 				ids = @record.send("#{par.to_s.singularize}_ids") if is_new
 				ids = @record.send("#{par.to_s.pluralize}").pluck(:id) if !is_new
 				ids_arr.push(ids) if !ids.nil?
 			else
 				id = @record.try("#{par.to_s}_id") if is_new
 				id = @record.try("#{par.to_s}").try(:id) if !is_new
 				ids_arr.push(id) if !id.nil?
 			end

 			model = par.to_s.classify.constantize
 			ids_arr = ids_arr.uniq
 			## pretoze in place metoda spravi z array nil ak bude obsahovat unikatne prvky
 			ids_to_load_count = 25 - ids_arr.length

 			if ids_to_load_count > 0
 				ids_arr.push(model.default_order.limit(ids_to_load_count).pluck(:id))
 			end

 			if !ids_arr.blank?
 				result = model.where(id: ids_arr.flatten).order_as_specified(id: ids_arr.flatten)
 				instance_variable_set("@#{par.to_s.pluralize}", result)
 			end
 		end
 	end

	def remember_param param
		controller_mem_set(param, params[param]) if params.has_key? param
		params[param] = controller_mem_get(param)
	end

	def remember_sortlink
		if params.deep_has_key? :q, :s
		  	controller_mem_set :s, params[:q][:s]
		elsif params.has_key? :q && !params[:q].blank?
		  	params[:q].merge!({ s: controller_mem_get(:s) })
		end
	end

	def remember_allow_search_as_new
		if (action_name == "new")||(action_name == "edit_multiple")||(action_name == "edit")
			# clear mem to not have turned on buttons on new forms
			@MEM.send("allow_add_new=", {})
		elsif (action_name == "create")||(action_name == "update")
			pars = params[controller_name.singularize]
			save_allow_search_as_new_to_mem(attr_set: pars)
		elsif action_name == "update_multiple"
			pars = params[controller_name]
			pars.each do |k, v|
				save_allow_search_as_new_to_mem(attr_set: v, multiedit: k)
			end
		end
	end

	def save_allow_search_as_new_to_mem(attr_set: [], multiedit: false)
		regex_to_get_assoc_model = /([a-z_]+)_attributes/
		nested_attrs_keys = attr_set.keys.select { |i| i[regex_to_get_assoc_model] }
		to_mem = @MEM.allow_add_new

		nested_attrs_keys.each do |na|
			if attr_set[na].keys.first == "0"
		  		# is has_many association, test if hash starts with number
		  		idx = 0
		  		attr_set[na].each do |par|
	  		 		if par[1].key? :allow_search_as_new
	  		 			# if given subset hash contains :allow_search_as_new
	  		 			assoc_model_name = na[regex_to_get_assoc_model].sub(/_attributes$/, "_#{idx.to_s}")
	  		 			to_mem[assoc_model_name] = par[1][:allow_search_as_new] == "1"
	  		 		end
	  		 		idx = idx + 1
	  		 	end
		  	else
		  		# is belongs to assoc
		  		assoc_model_name = na.sub(/_attributes$/, '')
		  		assoc_model_name += ("_" + multiedit) if multiedit != false
		  		to_mem[assoc_model_name] = attr_set[na][:allow_search_as_new] == "1"
		  	end
		end

		@MEM.send("allow_add_new=", to_mem)
	end


	def controller_mem_set prefix, val
		@MEM.send(
		  "#{prefix.to_s}_#{controller_name.singularize.underscore}=",
		  val
		)
	end

	def controller_mem_get prefix
		@MEM.send("#{prefix.to_s}_#{controller_name.singularize.underscore}")
	end

	def convert_params_to_date
        if params.deep_has_key? :q, "created_at(3i)"
            q = params[:q]
            q[:date_filter] = "#{q['created_at(1i)']}-#{q['created_at(2i)']}-#{q['created_at(3i)']}"
        end
    end

    def set_path_back(controller: params[:controller], action: params[:action])
    	#r = Rails.application.routes.router.recognize(request)
    	#logger
    	#logger request
    	#logger request[:controller]
    	session[:path_back] = { controller: controller, action: action }
    	#logger r[:controller]

    end

    def get_path_back
    	if !session[:path_back].nil?
    		if !session[:path_back][:controller].nil?
    			return session[:path_back]
    		end
    	end
    	return { controller: params[:controller], action: 'index' }
    end

    def last_visited_set
    	last_visits = controller_mem_get('last_visits')
    	last_visits = [] if last_visits.nil?
    	current = { id: @record.id, title: @record.name_field }
    	last_visits.delete(current) if last_visits.include?(current)
    	last_visits.unshift(current)
    	lng = last_visits.length
    	last_visits.pop(lng - _max_last_visited) if last_visits.length > _max_last_visited
    	controller_mem_set('last_visits', last_visits)

    end

    def last_visited_get
    	last_visits = controller_mem_get('last_visits')
    	last_visits = [] if last_visits.nil?
    	@last_visits = last_visits
    end

    def version_number_check
    	vn = "0.0.0"
	    vb = "00000000-0000"
	    if session[:APP_VER_NUM].nil?
	        @last_change = Change.last_change
	        if !@last_change.blank?
	            session[:APP_VER_NUM] = vn = @last_change.version_num
	            session[:APP_VER_BUILD] = vb = @last_change.created_at.strftime("%Y%m%d-%H%M")

	        else
	            session[:APP_VER_NUM] = vn
	            session[:APP_VER_BUILD] = vb
	        end
	    else
	        vn = session[:APP_VER_NUM]
	        vb = session[:APP_VER_BUILD]
	    end
    end

    def version_number
    	@version_number = session[:APP_VER_NUM]
    end

	module ClassMethods

	end

end
