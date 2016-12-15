module ApplicationHelper

	### cbt - controller based translation
	### helpful if you trying to keep discipline in YML files
	### by grouping translations into multiple keys and logical hierarchy
	### here I group translations by controllers and associated views
	### using this function in view you don't need to write too much 
	def cbt translation_key
		I18n.t(params[:controller] + "." + translation_key.to_s)
	end


	### function for higlighting (wrapping with tags) occurences in searched string
	# str -					whole string
	# patt -				pattern to be higlighted
	# case_insensitive - 	self-explaining
	# tag -					wrapping html element
	def highlight_searched str: "", patt: "", case_insensitive: true, tag: :em

		if patt.blank?
			return str
		else
			str_copy = str.dup
			open_tag = "<" + tag.to_s + ">"
			close_tag = "</" + tag.to_s + ">"
			patt_len = patt.length
			str_len = str.length;
			open_tag_len = open_tag.length
			tags_len = open_tag_len + close_tag.length

			positions = str_copy.enum_for(:scan, (Regexp.new patt, case_insensitive)).map { Regexp.last_match.begin(0) }

			positions.each_with_index do |p, i|
				pos_of_open_tag = p + (i * tags_len)
				pos_of_close_tag = pos_of_open_tag + open_tag_len + patt_len 
				str_copy.insert pos_of_open_tag, open_tag 
				str_copy.insert pos_of_close_tag, close_tag
			end
		end
		str_copy.html_safe
	end


	### function using prevoius highlihting function to higlight occurences in 
	### ransack gem search results
	# obj - 	resulting object
	# param - 	wanted attribute, for ex. have object with results from clients database,
	# 			and you want field with client name  
	def highlight_search obj, param, multiple_with=nil
		p = ""
		if params.has_key? :q
			if !params[:q].blank?
				tmp = multiple_with || param
				k = params[:q].keys.select { |key| key.to_s.match(Regexp.new("^" + tmp.to_s + "_.+$")) }.first
				p = params[:q][(k.to_sym)] if !k.blank?
			end
		end

		contr = controller_name.singularize.underscore
		obj_contr = obj.class.to_s.singularize.underscore
		if params.has_key?(contr.to_sym)
			if (contr == obj_contr)

			else
				# virtual params containig associated record(s)
				p = params[contr.to_sym][obj_contr + '_' + param.to_s]
			end
		end

		highlight_searched str: obj.send(param), patt: p 
	end


	### function for formatting kncode number output 
	# first part of HS/TARIC code is group of 4 numbers
	# other parts are groups of 2 numbers 
	def num_to_kncode num
		itm = num.dup
		str_len = itm.length
		divisions = str_len % 2 == 0 ? ((str_len / 2) - 2) : ((str_len / 2) - 1)
		startpos = 4
		for i in 0..divisions-1
			itm.insert(startpos, " ")
			startpos += (2 + (i + 1))
		end	
		return itm
	end


	### function for yelding content saved in content_for 
	# symb - 			same as first parameter of content_for function, symbol to your content
	# wrap tag - 		if specified, wraps content with this tag(s)
	# html_options -	for wrapping element if defined, html attributes like class, id, etc...
	def content_yelder symb, wrap_tag=nil, html_options={}
		end_tag, start_tag = "", ""

		if !wrap_tag.nil?
			start_tag = '<' + wrap_tag.to_s + '>'
			end_tag = start_tag.dup
			end_tag.insert(1, '/')
		end

		if !html_options.blank?
			options_string = ""
			html_options.each do |k, v|
				options_string += ' ' + k.to_s + '="' + v.to_s + '"'
			end
			start_tag.insert(start_tag.length-1, options_string)
		end

		html_string = start_tag + (content_for(symb) || " --- ") + end_tag
		html_string.html_safe
	end


	def return_selected_class_if_in_new_obj_attrs item, symsym
		if params.deep_has_key? controller_name.singularize.to_sym, symsym
			return 'class="selected"'.html_safe if item.id == params[:good][symsym].to_i
		end
	end


	def selected_html_class item, symsym
		if params.deep_has_key? controller_name.singularize.to_sym, symsym
			return "selected".html_safe if item.id == params[:good][symsym].to_i
		end
		""
	end


	def group_options obj
		[items: obj.to_a]
	end

	class ActionView::Helpers::FormBuilder

	  	def errors(field, continue: false)
		    if !@object.errors[field].blank? 
		    	err = ""
		    	if continue
			    	@object.errors[field].each do |e|
			    		err += @template.content_tag(:span, @object.errors.full_message(field, e))
			    	end
			    else
			    	e = @object.errors[field].first
			    	err += @template.content_tag(:span, @object.errors.full_message(field, e))
			    end
		    	return err.html_safe
		    end
	  	end

	end

	ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
	  class_attr_index = html_tag.index 'class="'

	  if class_attr_index
	    html_tag.insert class_attr_index+7, 'error '
	  else
	    html_tag.insert html_tag.index('>'), ' class="error"'
	  end
	end

end
