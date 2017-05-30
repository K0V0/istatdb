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
	def items_table_fields(obj, fields)
		output = ""
		fields.each do |field|
			field.each do |field_name, options|
				if options.is_a? Array
					output += items_table_fields(obj.send(field_name), options)
				else
					output += "<td class=\"#{obj.class.name.downcase}_#{field_name}\">"
					result = obj.send(field_name)
					if result.is_a? Array
						result.each do |res|

						end
					else
						output += items_table_field_decorator(result.to_s, options, obj, field_name)
					end
					output += "</td>"
				end 
			end
		end
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