module NewFormsHelper

	def select_blank_message(collection, msg_if_blank=nil, msg_if_any=nil)
		msg_if_blank ||= t('actions.nothing_to_select')
		msg_if_any ||= "#{t('actions.select')}..."
		collection.collect(&:id).any? ? msg_if_any : msg_if_blank
	end

	def get_fields_from_ransack_params
    	if params.has_key? :q
    		return params[:q].map { |k, v| k.to_s.sub(/_[a-z]+$/, '') }
    	end
    end

    # genrerates hash that is passed to rendering fuction only from variables
    # in arguments list that have been also defined in view where is called
    def generate_params_for_render_helper(local_assigns, *args)
        args_hash = {}
        args.each do |arg|
            if !(var_content = local_assigns[arg]).nil?
                args_hash[arg] = var_content
            end
        end
        return args_hash
    end

    # gets selected item (associated record id) from search bar filters 
    def get_selected_filter_obj_id_from_mem(association_name)
    	# only run when entering new form from list with items, 
    	# not on repeat after validation failed
    	if action_name == "new"
    		# params are restored from mem on page load if not new are set
    		if params.deep_has_key?(:q, "#{association_name}_filter".to_sym)
    			return params[:q]["#{association_name}_filter".to_sym].to_i
    		end
    	end
    	return false
    end

    def generate_labels_for_select_table(result_row, obj_name, coll_name, text_method, opts)
    	output = ""
    	[*text_method].each do |l|
			output += "<td>"
			output += label(
				obj_name,
				coll_name,
				result_row.send(l),
				value: result_row.id
			) do 
				items_table_field_decorator(result_row.send(l), opts, result_row, l)
			end 
			output += "</td>"
		end
		output
    end

    def new_form_has_many_select(obj: nil, coll: nil, val_method: :id, text_method: :id, opts: {})
    	output_first = ""
    	output_other = ""
    	# obj - passsed in AR object
		obj_name = "#{obj.class.name.underscore}"
		# coll - passed in collection to select from
		mem_param_name = "#{coll.name.underscore}"
		coll_name = "#{mem_param_name}_ids"
    	# this loads associations of passed in obj to match checked checkboxes later
		associated_records = obj.try("#{coll.name.pluralize.underscore}").pluck(:id)
		# this checks for params hash to catch if unsaved 
		pars = params.deep_has_key?(obj_name, coll_name) ? params[obj_name][coll_name] : []
		# id of association that is search limited (filtered) by
		id_from_search_filter = get_selected_filter_obj_id_from_mem(mem_param_name)

    	coll.each do |c|
    		output = ""
    		record_is_in_associated = associated_records.include?(c.id)
    		record_was_checked_before_validation_fail = pars.include?(c.id.to_s)
    		was_selected_in_search_bar_filter = id_from_search_filter == c.id
    		checked = record_is_in_associated||record_was_checked_before_validation_fail||was_selected_in_search_bar_filter

    		output += "<tr><td>"
	    		output += check_box(
					obj_name,
					coll_name,
					{ 
						multiple: true,
						checked: checked
					},
					c.id,
					""
				)
				output += "</td>"
				output += generate_labels_for_select_table(c, obj_name, coll_name, text_method, opts)
    		output += "</tr>"

    		output_first += output if checked
    		output_other += output if !checked 
    	end

    	(output_first + output_other).html_safe
    end

    def new_form_has_one_select(obj: nil, coll: nil, val_method: :id, text_method: :id, opts: {})
    	output_first = ""
    	output_other = ""
    	coll_name = "#{coll.name.underscore}_id"
        obj_name = "#{obj.class.name.underscore}"

    	checked_id = obj.try(coll.name.underscore).try(:id) 
    	pars = params.deep_has_key?(obj_name, coll_name) ? params[obj_name][coll_name] : []

    	coll.each do |c|
    		output = ""
            checked = (c.send(val_method).to_s == pars)||(checked_id == c.id)
    		output += "<tr><td>"
				output += radio_button(
					obj_name,
					coll_name,
					c.send(val_method),
					checked: checked
				) 
				output += "</td>"
				output += generate_labels_for_select_table(c, obj_name, coll_name, text_method, opts)

			output += "</tr>"
            
			output_first += output if checked
            output_other += output if !checked
    	end
    	(output_first + output_other).html_safe
    end

    # simple input text field generation
    def new_form_plain_textfield(obj: nil, field: nil, type: :text_field, default_val:nil)
        output = ""
        type = :text_field if type.nil?
        klass = "#{obj.object.class.name.underscore}_#{field.to_s}"

        output += default_val.nil? ? obj.send(type, field, class: klass) : obj.send(type, field, value: default_val, class: klass)
        output.html_safe
    end

    # for simple input text field generation - prefill with content of search field on main page
    # when adding sometning new
    def prefill_from_search_field(pars) 
        if (!pars.nil?)&&(action_name == 'new')
            search_params = @MEM.send("q_#{controller_name.singularize.underscore}")
            if !search_params.nil?
                pars.each do |par|
                    if !(res = search_params[par]).blank?
                        return res
                    end
                end
            end
        end
        return nil
    end

end