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

    # gets selected item (associated record id) from search bar filters 
    def get_selected_filter_obj_id_from_mem(association_name)
    	# only run when entering new form from list with items, 
    	# not on repeat after validation failed
    	if action_name = "new"
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

    def new_form_has_many_select(obj, coll, val_method, text_method, opts)
    	output_first = ""
    	output_other = ""
    	# obj - passsed in AR object
		obj_name = "#{obj.class.name.underscore}"
		# coll - passed in collection to select from
		mem_param_name = "#{coll.name.underscore}"
		coll_name = "#{mem_param_name}_ids"
    	# this loads associations of passed in obj to match checked checkboxes later
		associated_records = obj.send("#{coll.name.pluralize.underscore}")
		# this checks for params hash to catch if unsaved 
		pars = params.deep_has_key?(obj_name, coll_name) ? params[obj_name][coll_name] : []
		# id of association that is search limited (filtered) by
		id_from_search_filter = get_selected_filter_obj_id_from_mem(mem_param_name)

    	coll.each do |c|
    		output = ""
    		record_is_in_associated = !(associated_records.where(id: c.id).length == 0)
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

    def new_form_has_one_select(obj, obj_name, coll, val_method, text_method, opts)
    	output_first = ""
    	output_other = ""
    	coll_name = "#{coll.name.underscore}_id"
    	pars = params.deep_has_key?(obj_name, coll_name) ? params[obj_name][coll_name] : []

    	coll.each do |c|
    		output = ""
            checked = c.send(val_method).to_s == pars
    		#output += pars.to_s
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
    	output_first.html_safe
    end

end