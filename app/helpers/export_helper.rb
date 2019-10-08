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

	def render_excel_export_head(fields)
		ret = {
			lower: ["index"],
			higher: [nil]
		}
		fields.to_a.each do |field|
			if field[1].instance_of? String
				translation = "#{t("activerecord.attributes.#{controller_name.singularize}.#{field[0].to_s}")}"
				ret[:lower].push(translation)
				ret[:higher].push(nil)
			else
				field[1].each do |f|
					translation = "#{t("activerecord.models.#{field[0].singularize}")}"
					ret[:higher].include?(translation) ? ret[:higher].push(nil) : ret[:higher].push(translation)
					translation = "#{t("activerecord.attributes.#{field[0].singularize}.#{f[0].to_s}")}"
					ret[:lower].push(translation)
				end
			end
		end
		return ret
	end

	def render_excel_export_body(fields, obj)
		ret = []
		i = 0
		loop do
			row = []
			fields.each do |field|
				if field[1].instance_of? String
					if i==0
						row.push(obj.send(field[0]))
					else
						row.push(nil)
					end
				else
					if field[0].is_singular?
						if i==0
							field[1].each do |f|
								row.push(obj.send(field[0]).send(f[0]))
							end
						else
							row.push(nil)
						end
					else
						field[1].each do |f|
							row.push(obj.send(field[0])[i].try(f[0]))
						end
					end
				end
			end
			i = i+1
		  	break if ((row.all? { |r| r.nil? })||(row.blank?))
		  	ret.push(row)
		end
		return ret
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

	def is_param?(param)
		if params.deep_has_key?(:q, param)
			if !(p = params[:q][param]).blank?
				return p
			else
				return false
			end
		else
			return false
		end
	end

end
