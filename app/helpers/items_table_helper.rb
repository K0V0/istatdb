module ItemsTableHelper

	### function to format output of field in items tables based on passed options
	#
	# text - text to proccess
	# opts - passed in array with named options
	# object - singular activerecord object, one result (row) from set
	# field - field name callable to AR object

	### options list
	#
	# call_decorator 	pass text to function
	# 					input is defined function name
	# is_higlighted  	is connected with ransack searcher, highlights matched parts of searched text
	# 					input true or false
	# is_link			creates link to show action, detemined from passed AR object
	# 				 	input true, false or options hash
	# 					options: remote - if link is remoted (true/false)  
	# clipboard_button	creates small scissors icon next to item, by clicking it related content will
	# 					be copied to clipboard	
	#			
	def items_table_field_decorator(text, opts, object, field)
		
		if opts[:call_decorator]
			text = self.send(opts[:call_decorator], text)
		end

		if opts[:is_highlighted]
			patt = highlight_search(object, field, opts[:is_multiple_with], true)
			text = highlight_searched(str: text, patt: patt)
		end

		if opts[:clipboard_button]
			#text = "<span class=\"to_clipboard\" id=\"#{row_id}_#{field_class}\">#{text.to_s}</span><b class=\"copy_to_clipboard\" data-clipboard-action=\"copy\" data-clipboard-target=\"##{row_id}_#{field_class}\">&#9986</b>".html_safe
		end

		if opts[:is_link]
			text = link_to object, remote: opts[:is_link].try(:[], :remote) do
				text
			end
		end

		return text
	end

	### something like above but for table header
	#
	def items_table_caption_decorator(opts, object, field)
		ret = object.human_attribute_name(field)

		if opts[:is_sortlink]
			ret = sort_link(@search, field, { action: :search }, remote: true)  
		end

		return ret
	end

	### function to support errors on items table
	#
	# errors - list of defined errors to respond to and option
	# object - passed plural AR object
	#
	def items_table_errors_handler(errors, object)
		ret = ""

		if errors[:no_results]
			if object.length == 0
				if part = errors[:no_results].try(:partial)
					ret = render(part, object)
				else
					ret = render('layouts/shared/items_table/no_results')
				end
			end
		end

		return ret
	end

	### function to render row in a table
	#
	# obj - one row from AR result set
	# fields - named columns to display, work recursively when some column have association(s)
	#
	def items_table_fields(obj, fields, no_wrap=false)
		output = ""
		fields.each do |field|
			field.each do |field_name, options|
				obj_is_collection = obj.is_a? ActiveRecord::Associations::CollectionProxy
				if options.is_a? Array
					# for deeper nested associations
					if obj_is_collection
						options[0].each do |k, v|
							output += "<td class=\"#{obj.first.class.name.downcase}-#{field_name}-#{k.to_s}\">"
							obj.each do |res|
								output += items_table_fields(res.send(field_name), [{k => v}], true)
							end
							output += "</td>"
						end
					else
						output += items_table_fields(obj.try(field_name), options, no_wrap)
					end
				else
					output += "<td class=\"#{obj.class.name.downcase}_#{field_name}\">" if !no_wrap&&!obj_is_collection
					output += "<td class=\"#{obj.first.class.name.downcase}-#{field_name}\">" if !no_wrap&&obj_is_collection
					# if is many-type association
					if obj_is_collection
						obj.each do |res|
							result = res.send(field_name).to_s
							output += items_table_field_decorator(result, options, obj, field_name)
							output += "<br>"
						end
					# if is has-one type association
					else
						result = obj.try(field_name).to_s
						output += items_table_field_decorator(result, options, obj, field_name)
					end
					output += "</td>" if !no_wrap
				end 
			end
		end
		return output.html_safe 
	end

	### function to render edit and delete buttons in table row
	#
	# obj - one row from AR result set
	#
	def items_table_row_administrative_buttons(obj)
		output = "<td>"
			output += link_to(
				t('actions.edit'),
				{
					controller: controller_name,
					action: "edit",
					id: obj.id
				},
				class: "button edit_item"
			)
		output += "</td><td>"
			output += link_to(
				t('actions.delete'),
				{
					controller: controller_name,
					action: "delete",
					id: obj.id
				},
				data: { confirm: t('actions.ru_sure_delete') },
				method: :delete,
				class: "button danger delete_item"
			)
		output += "</td>"
		return output.html_safe
	end

	### same purpose as above, but for table header
	#
	def items_table_head(obj, fields)
		output = ""
		fields.each do |field| 
			field.each do |field_name, options| 
		 		if options.is_a? Array 
		 			output += items_table_head(field_name.to_s.classify.constantize, options)
		 		else 
					output += "<th class=\"#{obj.model_name.name.downcase}_#{field_name}\"> #{items_table_caption_decorator(options, obj, field_name)} </th>" 
				end 
			end 
		end 
		return output.html_safe
	end

end