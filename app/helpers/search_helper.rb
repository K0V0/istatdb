module SearchHelper

	def select_attr(attrs: "", obj: nil, field: nil, is_label: false)
		ret = []
		if attrs.is_a?(Array)&&!params[:q].nil?
			ret = (params[:q].keys.map(&:to_sym) & attrs).first
		elsif attrs.is_a?(Array)
			ret = attrs.first
		else
			ret = attrs
		end

		if controller_name.classify.constantize.try(:translated?, field)
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

	def render_multiselect(obj: nil)
		params_filter_key = multiselect_filter_key(obj: obj)
		selected = get_selected_multiselect(obj: obj, filter_key: params_filter_key)
 		output = ""

 		if selected.nil?
 			obj.each do |man|
		 		output += render_multiselect_row(obj:man, filter_key: params_filter_key)
		 	end
 		else
		 	obj.select { |x| selected.include?(x.id) }.each do |man|
		 		output += render_multiselect_row(obj:man, checked:true, filter_key: params_filter_key)
		 	end
		 	obj.select { |x| !selected.include?(x.id) }.each do |man|
		 		output += render_multiselect_row(obj:man, filter_key: params_filter_key)
		 	end
		end
	 	output.html_safe
	end

	def multiselect_filter_key(obj:nil)
		"#{obj.model_name.name.downcase}_filter"
	end

	def get_selected_multiselect(obj: nil, filter_key: nil)
		if params.deep_has_key?(:q, filter_key)
			if (a = params[:q][filter_key]).instance_of?(Array)
				if a.all? { |x| x.blank? }
					return nil
				else
					return a.map { |x| x.to_i }
				end
			else
				return nil
			end
 		end
	end

	def render_multiselect_row(obj:nil, checked:false, filter_key:nil)
		output = "<span>"
		output += check_box_tag(
			"q[#{filter_key}][]",
			obj.id,
			checked,
			{
				id: "q_#{filter_key}_#{obj.id}",
				class: 'skip_events'
			}
		)
		output += ""
		output += label_tag(
			"q[#{filter_key}][#{obj.id}]",
			obj.name_field
		)
		output += "</span>"
	end
end
