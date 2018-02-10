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

  	def user_logged_and_model_exist
  		return user_signed_in?&&model_exist?
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

	def build_if_empty(*assocs)
		
		if action_name == "new" || action_name == "create"

			assocs.each do |a, opts|
				assoc_var_name = "@#{a.to_s.singularize}"
				build_command = a.to_s.is_singular? ? "build_#{a.to_s}" : "build"

				if (a.to_s.is_singular?)
					if @record.has_attribute? "#{a.to_s}_id"
						if @record.send(a).nil?
							instance_variable_set(assoc_var_name, @record.send(build_command))
						else
							instance_variable_set(assoc_var_name, @record.send(a))
						end
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
				if (a.to_s.is_singular?)

				else
					@record.send(a).send(:build)
				end
			end

		end
	end

	def apicall_render(type_of_assoc)
		render("layouts/shared/new_edit_form/#{type_of_assoc.to_s}")
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
		regex_to_get_assoc_model = /([a-z_]+)_attributes/
		singular_controller_name = controller_name.singularize
		pars = params[singular_controller_name]

		if action_name == "new"
			# clear mem to not have turned on buttons on new forms
			@MEM.send("allow_add_new=", {})
		elsif action_name == "create"
			nested_attrs_keys = pars.keys.select { |i| i[regex_to_get_assoc_model] }
			#logger(nested_attrs_keys, "attr keys")
	  		nested_attrs_keys.each do |na|
		  		if pars[na].keys.first == "0"
		  		 	# is has_many association
		  		 	to_mem = @MEM.allow_add_new
		  		 	pars[na].each do |par|
		  		 		#logger par, "par"
		  		 		if par[1].key? :allow_search_as_new
		  		 			assoc_model_name = na[regex_to_get_assoc_model].sub(/_attributes$/, '')
		  		 			is_adding_allowed = par[1][:allow_search_as_new] == "1"
		  		 			to_mem[assoc_model_name] = is_adding_allowed
		  		 		end
		  		 	end
		  		 	@MEM.send("allow_add_new=", to_mem)
		  		else
		  			#logger("singularize")
		  		 	# is single association
		  		 	#logger(na, "na")
		  		 	#logger(na.sub(/_attributes$/, ''), "na")
		  		 	#logger pars[na][:allow_search_as_new], "pars na"
		  		 	to_mem = @MEM.allow_add_new
		  		 	to_mem[na.sub(/_attributes$/, '')] = pars[na][:allow_search_as_new] == "1"
		  		 	@MEM.send("allow_add_new=", to_mem)
		  		end
			end
		end
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

	module ClassMethods

	end

end