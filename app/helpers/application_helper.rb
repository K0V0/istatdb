module ApplicationHelper

	### cbt - controller based translation
	# helpful if you trying to keep discipline in YML files
	# by grouping translations into multiple keys and logical hierarchy
	# here I group translations by controllers and associated views
	# using this function in view you don't need to write too much 
	def cbt translation_key
		t(params[:controller] + "." + translation_key.to_s)
	end

	### function for higlighting (wrapping with tags) occurences in searched string
	def highlight_searched str, patt, case_insensitive=true, open_tag="<em>", close_tag="</em>"
		if patt.blank?
			return str
		else
			patt_len = patt.length
			str_len = str.length
			open_tag_len = open_tag.length
			tags_len = open_tag_len + close_tag.length

			positions = str.enum_for(:scan, (Regexp.new patt, case_insensitive)).map { Regexp.last_match.begin(0) }

			positions.each_with_index do |p, i|
				pos_of_open_tag = p + (i * tags_len)
				pos_of_close_tag = pos_of_open_tag + open_tag_len + patt_len 
				str.insert pos_of_open_tag, open_tag 
				str.insert pos_of_close_tag, close_tag
			end
		end
		str.html_safe
	end

	### function using prevoius highlihting function to higlight occurences in 
	### ransack gem search results
	# obj - 	resulting object
	# param - 	wanted attribute, for ex. have object with results from clients database,
	# 			and you want field with client name  
	def highlight_search obj, param
		p = ""
		if params.has_key? :q
			k = params[:q].keys.select { |key| key.to_s.match(Regexp.new("^" + param.to_s + "_.+$")) }.first
			p = params[:q][(k.to_sym)] if !k.blank?
		end
		highlight_searched obj.send(param), p 
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


end
