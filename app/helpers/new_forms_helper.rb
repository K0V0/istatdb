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

    def new_form_has_many_select(obj, coll, val_method, text_method, opts)
    	output = ""
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

		#b = ""
		#if !id_from_search_filter.blank?
		#	coll = coll.order_this_id_first(id_from_search_filter)
		#	a = coll.order_this_id_first(id_from_search_filter)
		#	a.each do |out|
		#		b += "#{out.id.to_s} "
		#	end
		#end

		# spravit zoradenie vysvietenych ako prve

    	coll.each do |c|
    		record_is_in_associated = !(associated_records.where(id: c.id).length == 0)
    		record_was_checked_before_validation_fail = pars.include?(c.id.to_s)
    		was_selected_in_search_bar_filter = id_from_search_filter == c.id
    		checked = record_is_in_associated||record_was_checked_before_validation_fail||was_selected_in_search_bar_filter

    		output += "<tr>"

    			output += b

	    		output += "<td>"
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
	    		
	    		[*text_method].each do |l|
					output += "<td>"
					output += label(
						obj_name,
						coll_name,
						c.send(l),
						value: c.id
					) do 
						items_table_field_decorator(c.send(l), opts, c, l)
					end 
					output += "</td>"
				end

    		output += "</tr>"
    	end

    	output.html_safe
    end

end