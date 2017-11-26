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

		if opts[:fill_if_empty]
			text = fill_if_empty(text, opts[:fill_if_empty])
		end

		if opts[:call_decorator]
			text = self.send(opts[:call_decorator], text)
		end
		
		if !object.nil?

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

		end

		return text
	end

	def render_field(obj, field, options)
		output = "<td class=\"#{obj.class.to_s.underscore.pluralize}-#{field}\">"
		output += items_table_field_decorator(obj.send(field).to_s, options, obj, field)
		output += "</td>"
		return output
	end

	### function to render edit and delete buttons in table row
	#
	# obj - one row from AR result set
	#
	def items_table_row_administrative_buttons(obj)
		output = "<td class=\"edit_item\">"
			output += link_to(
				t('actions.edit'),
				{
					controller: controller_name,
					action: "edit",
					id: obj.id
				},
				class: "button"
			)
		output += "</td><td class=\"delete_item\">"
			output += link_to(
				t('actions.delete'),
				{
					controller: controller_name,
					action: "delete",
					id: obj.id
				},
				data: { confirm: t('actions.ru_sure_delete') },
				method: :delete,
				class: "button danger"
			)
		output += "</td>"
		return output.html_safe
	end

	### function to render row in a table
	#
	# obj - one row from AR result set
	# fields - named columns to display, work recursively when some column have association(s)
	#
	def items_table_fields(obj, fields)
		output = ""
		fields.each do |field, content|

			if content.is_a? Hash
				# is on current model attribute
				# last recursion level happens here
				output += render_field(obj, field, content)

			elsif content.is_a? Array
				# is on associated model
				if field.to_s.is_singular?
					# 1 to 1 or 1 to X assoc
					if !(f = obj.try(field)).nil?
						output += items_table_fields(f, content[0])
					else
						# do not leave empty fields - every row should have equal number of columns 
						content[0].each do |k, v|
							output += 
								"<td class=\"#{field.to_s.pluralize}-#{k.to_s}\">
									#{items_table_field_decorator('', v, nil, nil)}
								</td>"
						end
					end
				else
					# has_many assoc
					output += "<td class=\"inner_table\"><table class=\"inner_table\"><tbody>"
					obj.send(field).each do |f|
						output += "<tr>"
						output += items_table_fields(f, content[0])
						output += "</tr>"
					end
					output += "</tbody></table></td>"
				end
			end

		end
		return output.html_safe 
	end

	def items_table_caption_decorator(opts, object, field)
		ret = object.human_attribute_name(field)

		if opts[:is_sortlink]
			ret = sort_link(@search, field, { action: :search }, remote: true)  
		end

		return ret
	end

	def items_table_head(fields, model=controller_name.classify.constantize)

		output = ""
		fields.each do |field, content|
			if content.is_a? Hash
				# is on current model attribute
				output += "<th class=\"#{model.name.pluralize.underscore}-#{field.to_s}\">"
				output += items_table_caption_decorator(content, model, field)
				output += "</th>"

			elsif content.is_a? Array
				# is inside associated
				output += "<th class=\"inner_table\"><table class=\"inner_table\"><thead>"
				output += items_table_head(content[0], field.to_s.classify.constantize)
				output += "</thead></table></th>"
			end
		end

		return output.html_safe
	end

	### function to support errors on items table
	#
	# errors - list of defined errors to respond to and option
	# object - passed plural AR object
	#
	def items_table_errors_handler(errors, object)
		ret = ""
		# if nothing found
		if errors[:no_results]
			if object.length == 0
				if errors[:no_results].has_key? :partial
					ret = render(errors[:no_results][:partial], obj: object)
				else
					ret = render('layouts/shared/items_table/no_results')
				end
			end
		end
		return ret
	end

	def visible_results_stats(res_on_actual_page, page_num, res_per_page)
		output = ""
		res_first = res_per_page * (page_num - 1) + 1
		res_last = (page_num - 1) * res_per_page + res_on_actual_page
		if page_num > 0
			if res_first != res_last
				output = ", #{t('actions.i_am_showing')} #{t('actions.items')} <b>#{res_first}</b> - <b>#{res_last}</b>"
			elsif page_num > 1
				output = ", #{t('actions.i_am_showing')} #{t('actions.item')} <b>#{res_first}</b>"
			end
		end
		output
	end

	private :render_field

end