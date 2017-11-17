module ApplicationConcern
	extend ActiveSupport::Concern

	### log to console with better visibility
	def logger(input, description="", **options)
		Rails.logger.info "-- #{description} ----------------------------------"
		Rails.logger.info input
		if options[:iterate]
			if input.respond_to?(:length)
				Rails.logger.info "-- count: #{input.try(:length)} --"
				input.each do |inp|
					Rails.logger.info inp
				end
				Rails.logger.info "-- end --"
			end
		end
		Rails.logger.info " "
	end

	### retruns model instance based on controller name if exists
	### else nil
	def model_exist?
		Module.const_get(controller_name.classify)
	rescue NameError
		return nil
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

	def remember_settings
		if @MEM.settings == nil
			@MEM.send("settings=", Setting.load)
		end
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
	  		nested_attrs_keys.each do |na|
		  		if pars[na].keys.first == "0"
		  		 	# is has_many association
		  		 	to_mem = @MEM.allow_add_new
		  		 	pars[na].each do |par|
		  		 		if par[1].key? :allow_search_as_new
		  		 			assoc_model_name = na[regex_to_get_assoc_model].sub(/_attributes$/, '')
		  		 			is_adding_allowed = par[1][:allow_search_as_new] == "1"
		  		 			to_mem[assoc_model_name] = is_adding_allowed
		  		 		end
		  		 	end
		  		 	@MEM.send("allow_add_new=", to_mem)
		  		else
		  		 	# is single association
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