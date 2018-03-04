module SearchHelper

	def select_attr(attrs: "", obj: nil, field: nil, is_label: false)
		ret = []
		if attrs.is_a?(Array)&&!params[:q].nil?
			#return (params[:q].keys.map(&:to_sym) & attrs).first
			ret = (params[:q].keys.map(&:to_sym) & attrs).first
		elsif attrs.is_a?(Array)
			#return attrs.first
			ret = attrs.first
		else
			#return attrs
			ret = attrs
		end
		#logger ret, "ret"
		#logger obj.object.class.model_name, "se obj"
		#logger obj.try(:translated_locales), "trans has"
		#logger field, "field"
		#logger obj.object.translated?(:kncode)

		#logger controller_name.classify.constantize.try(:translated_locales), "trans locals"
		#
		#logger controller_name.classify.constantize

		if controller_name.classify.constantize.try(:translated?, field)
			#ret = "translations_" + ret.to_s
			#logger field, "translated"
			ret = "translations_#{ret.to_s}"
		end

		ret
	end

	def render_searchfield(obj: nil, field: nil, pars: nil, index:0)

		output =
			"<span>
				#{
					obj.label(
						select_attr(attrs: pars, obj: obj, field: field, is_label: true),
						id: "#{field.to_s}_searchfield_label"
					)
				}
			</span>
			<span class=\"searchform_inputfield_wrap\">
				#{
					obj.search_field(
						select_attr(attrs: pars, obj: obj, field: field),
						autocomplete: "off",
						autofocus: index == 0 ? "autofocus" : false,
						class: "#{field.to_s}_searchfield"
					)
				}
			</span>"

		return output.html_safe
	end
end
