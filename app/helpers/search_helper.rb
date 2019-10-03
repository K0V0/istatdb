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

	def render_manufacturers_select(obj: nil)
		manufacturers_selected = params.deep_has_key?(:q, :manufacturer_filter) ? (params[:q][:manufacturer_filter].map { |x| x.to_i })
 : nil
 		output = ""

 		if manufacturers_selected.nil?
 			@manufacturers.each do |man|
		 		output += render_manufacturers_select_row(obj:man)
		 	end
 		else
		 	@manufacturers.select { |x| manufacturers_selected.include?(x.id) }.each do |man|
		 		output += render_manufacturers_select_row(obj:man, checked:true)
		 	end
		 	@manufacturers.select { |x| !manufacturers_selected.include?(x.id) }.each do |man|
		 		output += render_manufacturers_select_row(obj:man)
		 	end
		end
	 	output.html_safe
	end

	def render_manufacturers_select_row(obj:nil, checked:false)
		output = "<span>"
		output += check_box_tag(
			'q[manufacturer_filter][]',
			obj.id,
			checked,
			{
				id: "q_manufacturer_filter_#{obj.id}"
			}
		)
		output += ""
		output += label_tag(
			"q[manufacturer_filter][#{obj.id}]",
			obj.name
		)
		output += "</span>"
	end
end
