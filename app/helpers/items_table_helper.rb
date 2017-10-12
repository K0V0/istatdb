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

	### function to render row in a table
	#
	# obj - one row from AR result set
	# fields - named columns to display, work recursively when some column have association(s)
	#

=begin
	def items_table_fields(obj, fields, no_wrap=false, recurse_deep_level=1)
		output = ""

		fields.each do |field, content|
			prependix = ""
			recurse_deep_level.times do 
				prependix += " - "
			end

			if content.is_a? Hash
				# is on current model attribute
				output += "#{prependix} #{field.to_s} <br>"
				output += "#{prependix} #{content.to_s}<br>"
				render_field(obj.send(field), content)

			elsif content.is_a? Array
				# is on associated model
				output += "#{prependix} #{field.to_s} <br>"

				if field.to_s.is_singular?
					# 1 to 1 or 1 to X assoc
					if !(f = obj.try(field)).nil?
						output += items_table_fields(f, content[0], no_wrap, recurse_deep_level+1)
					end
				else
					# has_many assoc
					obj.send(field).each do |f|
						output += items_table_fields(f, content[0], no_wrap, recurse_deep_level+1)
					end
				end
			end
		end

		output += "<br>"
		return output.html_safe 
	end
=end
#=begin
	def items_table_fields(obj, fields, is_inner=false)
		output = ""
		fields.each do |field, content|

			if content.is_a? Hash
				# is on current model attribute
				# last recursion level happens here
				output += render_field(obj.send(field), content) if !is_inner

			elsif content.is_a? Array
				# is on associated model
				if field.to_s.is_singular?
					# 1 to 1 or 1 to X assoc
					if !(f = obj.try(field)).nil?
						output += items_table_fields(f, content[0], is_inner)
					else
						# do not leave empty fields - every row should have equal number of columns 
						output += "<td></td>"
					end
				else
					# has_many assoc
					output += "<td><table><tbody>"
					obj.send(field).each do |f|
						output += "<tr>"
						output += items_table_fields(f, content[0], is_inner)
						output += "</tr>"
					end
					output += "</tbody></table></td>"
				end
			end

		end
		return output.html_safe 
	end
#=end
	def render_field(obj, options)
		output = "<td>"
		output += "#{obj.to_s}"
		#output += items_table_field_decorator(result, options, obj, field_name)
		output += "</td>"
		return output
	end

	#def render_inner_table(cells: "")
	#	output = "<td><table><tbody>"
	#	output += cells
	#	output += "</tbody></table></td>"
	#	return output
	#end

=begin
	def items_table_fields(obj, fields, no_wrap=false)
		output = ""
		#output += "#{obj.class}"
		fields.each do |field|
			#output += "#{field.to_s}"
			field.each do |field_name, options|
				obj_is_collection = obj.is_a? ActiveRecord::Associations::CollectionProxy
				if options.is_a? Array
					# for deeper nested associations
					#output += "#{field.to_s} <br><br>"
					if obj_is_collection
						#output += "#{obj.class} #{field.to_s} <br><br>"
						options[0].each do |k, v|
							#output += "#{k} #{v} #{obj.class} #{field.to_s} <br><br>"
							#output += "#{obj.class} #{field.to_s} <br><br>"
							output += "<td class=\"#{obj.first.class.name.downcase}-#{field_name}-#{k.to_s}\">"
							obj.each do |res|
								output += "<span class=\"itemstable_subitem r#{res.id.to_s}\">"
								output += items_table_fields(res.send(field_name), [{k => v}], true)
								output += "</span>"
							end
							output += "</td>"
						end
					else
						#output += "#{obj.class} #{field.to_s} <br><br>"
						output += items_table_fields(obj.try(field_name), options, no_wrap)
					end
				else
					output += "<td class=\"#{obj.class.name.downcase}_#{field_name}\">" if !no_wrap&&!obj_is_collection
					#output += "<td class=\"#{obj.first.class.name.downcase}-#{field_name}\">" if !no_wrap&&obj_is_collection
					# if is many-type association
					#if obj_is_collection
						#obj.each do |res|
						#	result = res.send(field_name).to_s
						#	output += items_table_field_decorator(result, options, obj, field_name)
						#	output += "<br>"
						#end
					# if is has-one type association
					#else
					#output += "#{fields}"
					#output += "#{no_wrap}"
						output += "<span class=\"itemstable_item\">" if !no_wrap
						result = obj.try(field_name).to_s
						output += items_table_field_decorator(result, options, obj, field_name)
						output += "</span>" if !no_wrap
					#end
					output += "</td>" if !no_wrap
				end 
			end
		end
		return output.html_safe 
	end
=end

	### function to render edit and delete buttons in table row
	#
	# obj - one row from AR result set
	#
	def items_table_row_administrative_buttons(obj)
		output = "<td><span>"
			output += link_to(
				t('actions.edit'),
				{
					controller: controller_name,
					action: "edit",
					id: obj.id
				},
				class: "button edit_item"
			)
		output += "</span></td><td><span>"
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
		output += "</span></td>"
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

	private :render_field

end