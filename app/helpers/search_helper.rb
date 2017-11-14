module SearchHelper

	def select_attr(attrs)
		if attrs.is_a? Array
			return (params[:q].keys.map(&:to_sym) & attrs).first
		else
			return attrs
		end
	end

	def render_searchfield(obj: nil, field: nil, pars: nil, index:0)

		output = 
			"<span>
				#{ 
					obj.label(
						select_attr(pars),
						id: "#{field.to_s}_searchfield_label"
					) 
				}
			</span>
			<span class=\"searchform_inputfield_wrap\">
				#{ 
					obj.search_field(
						select_attr(pars),
						autocomplete: "off",
						autofocus: index == 0 ? "autofocus" : false,
						id: "#{field.to_s}_searchfield"
					)
				}
			</span>"

		return output.html_safe
	end
end