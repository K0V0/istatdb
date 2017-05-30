module ShowItemHelper

	def get_content_for(obj, att)
		if att.class == Array && att.length > 1
			get_content_for(obj.send(att.first), att.drop(1))
		else
			if !att[0].is_a? Hash
				return obj.send(*att)
			else
				att[0].each do |key, val|
					return items_table_field_decorator(obj.send(key), val, obj, key)
				end
			end
		end
	end

end