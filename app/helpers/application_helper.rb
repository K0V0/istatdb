module ApplicationHelper

	### cbt - controller based translation
	### trying to keep transtations organized, imagine you have t(:foo) somewhere in views
	### associated to GoodsController, in YML file you write:
	### <your lang>:
	###   goods:
	###     foo: BAR
	def cbt translation_key
		I18n.t(params[:controller] + "." + translation_key.to_s).gsub(/\n/, "<br>").html_safe
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
			patt_mod = patt.chars.map { |p| "\s?[#{p}]" } .join
			pattern = /(#{patt_mod})/i
			tmp = str.gsub(pattern) do |x| 
				if x =~ /^\s/
					" <#{tag.to_s}>#{x.strip}</#{tag.to_s}>"
				else 
					"<#{tag.to_s}>#{x}</#{tag.to_s}>"
				end 
			end .html_safe
		end
	end


	### function using prevoius highlihting function to higlight occurences in 
	### ransack gem search results
	# obj - 	resulting object
	# param - 	wanted attribute, for ex. have object with results from clients database,
	# 			and you want field with client name  
	def highlight_search obj, param, multiple_with=nil, return_patt=false
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

		return p if return_patt == true
		highlight_searched str: obj.send(param), patt: p 
	end


	### function for formatting kncode number output 
	# first part of HS/TARIC code is group of 4 numbers
	# other parts are groups of 2 numbers 
	def num_to_kncode num
		return num.gsub(/.{2}/).with_index {|x, i| i > 0 ? "#{x} " : "#{x}" } .strip
	end

end
