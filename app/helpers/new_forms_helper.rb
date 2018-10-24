module NewFormsHelper

	def select_blank_message(collection, msg_if_blank=nil, msg_if_any=nil)
		msg_if_blank ||= t('actions.nothing_to_select')
		msg_if_any ||= "#{t('actions.select')}..."
		collection.collect(&:id).any? ? msg_if_any : msg_if_blank
	end

	def get_fields_from_ransack_params
    	if params.has_key? :q
    		return params[:q].map { |k, v| k.to_s.sub(/_[a-z]+$/, '').sub('translations_', '') }
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
		associated_records = obj.try("#{coll.name.pluralize.underscore}").try(:pluck, :id)
		# this checks for params hash to catch if unsaved
		pars = params.deep_has_key?(obj_name, coll_name) ? params[obj_name][coll_name] : []
		# id of association that is search limited (filtered) by
		id_from_search_filter = get_selected_filter_obj_id_from_mem(mem_param_name)

		if coll.length > 0
	    	coll.each do |c|
	    		output = ""
                # do this only on edit - preloads values from parent object
                # must do hack, because after validation checkboxes defaultly preselected appeared (parent associations)
	    		record_is_in_associated = (action_name == "edit" ? associated_records.include?(c.id) : false)
	    		# check comparing to params if should be checked (e.g. render after validation fail)
                record_was_checked_before_validation_fail = pars.include?(c.id.to_s)
                # preselecting for faster UX if searched with filters, do only on new
	    		was_selected_in_search_bar_filter = (action_name == "new" ? id_from_search_filter == c.id : false)

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
	    else
	    	output_first += new_forms_no_results
	    end

    	(output_first + output_other).html_safe
    end

    def new_form_has_one_select(obj: nil, coll: nil, val_method: :id, text_method: :id, opts: {}, multiedit: false)
    	output_first = ""
    	output_other = ""
    	coll_name = "#{coll.name.underscore}_id"
        obj_name = "#{obj.class.name.underscore}"
        obj_name = "#{obj_name.pluralize}[#{obj.try(:id).to_s}]" if multiedit == true
    	checked_id = obj.try(coll.name.underscore).try(:id)
    	pars = params.deep_has_key?(obj_name, coll_name) ? params[obj_name][coll_name] : []

    	if coll.length > 0
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
	    else
	    	output_first += new_forms_no_results
	    end
    	(output_first + output_other).html_safe
    end

    def new_forms_no_results
    	output = "<tr><td colspan=\"10\" class=\"new_form_select_no_results\">"
    	output += "
    		<h2>#{t('items_table.nothing_found')}.</h2>
    			#{t('new_form_selects.try_to_add_as_new_1a')}
    			<b>\"#{t('search.search_as_new')}\"</b>
    			#{t('new_form_selects.try_to_add_as_new_1b')}.<br>
    		<i>#{t('new_form_selects.try_to_add_as_new_2')}.</i>
    	"
    	output += "</td></tr>"
    	output
    end

    # simple input text field generation
    #
    # obj 			- FormBuilder object
    # field 		- column in table (AR) that is field related to
    # type 			- type of textfield (like text_area, search_field)
    # default_val 	- default value if field has no value
    def new_form_plain_textfield(obj: nil, field: nil, type: :text_field, default_val:nil, autofocus: false, js_check_existence: false, html_class: "", required: false)
        output = ""
        klass = ""
        parent_obj_model_name = obj.object.class.name.underscore

        type = :text_field if type.nil?
        required = false if required.nil?
        klass += " js_check_existence " if js_check_existence
        klass += "#{parent_obj_model_name}_#{field.to_s} #{html_class}"
        data = js_check_existence ? { model: parent_obj_model_name, field: field.to_s } : ""

        options = { class: klass, autofocus: autofocus, required: required, data: data, autocomplete: 'off' }
        options.merge!(value: default_val) if !default_val.nil?
        arguments = [ type, field ]
        arguments += [ options ]
        output += obj.send(*arguments)
        output.html_safe
    end

    # for simple input text field generation - prefill with content of search field on main page
    # when adding sometning new
    def prefill_from_search_field(pars)
        if (!pars.nil?)&&(action_name == 'new')
            logger(params)
            search_params = (params[:prefill] || @MEM.send("q_#{controller_name.singularize.underscore}"))
            if !search_params.nil?
                pars.each do |par|
                    if !(res = search_params[par.to_s.sub(/(_[a-z]+)$/, '')]).blank?
                        ## from searcher section
                        return res
                    end
                    if !(res = search_params[par]).blank?
                        ## from other sections
                        return res
                    end
                end
            end
        end
        return nil
    end

    def generate_search_instructions(ss, assoc)
        new_query = {}
        ss[:query].each do |k, v|
            if assoc.to_s.classify.constantize.try(:translated?, k)
                new_query["translations_" + k.to_s] = v
            else
                new_query[k] = v
            end
        end
        return "data-searcher-query=#{new_query.to_json}" +
        " data-searcher-assoc=#{assoc.to_s}"
    end

end
