module ExportHelper

	def render_html_export_head(field, mdl: controller_name.singularize)
		if field[1].instance_of? String
			return "<td>#{t("activerecord.attributes.#{mdl}.#{field[0].to_s}")}</td>".html_safe
		else
			mdl = field[0].singularize
			str = "<td class=\"subtable\"><table><tr>"
			str += "<td><b>#{t("activerecord.models.#{mdl}")}</b></td>"
			str += "</tr><tr>"
			field[1].each do |f|
				str += render_html_export_head(f, mdl: mdl)
			end
			str += "</tr></table></td>"
			return str.html_safe
		end
	end

	def render_html_export_body(field, obj, cont=false)
		if field[1].instance_of? String
			return "<td>#{obj.send(field[0])}</td>".html_safe
		elsif cont == true
			str = "<tr>"
			field.each do |f|
				str += render_html_export_body(f, obj)
			end
			str += "</tr>"
		else
			str="<td class=\"subtable\"><table>"
			if field[0].is_singular?
				str += render_html_export_body(field[1], obj.send(field[0]), true)
			else
				obj.send(field[0]).each do |o|
					str += render_html_export_body(field[1], o, true)
				end
			end
			str += "</table></td>"
			str.html_safe
		end
	end

end
