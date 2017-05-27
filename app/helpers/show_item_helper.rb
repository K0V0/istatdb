module ShowItemHelper

	def get_content_for(obj, att)
		if att.class == Array && att.length > 1
			get_content_for(obj.send(att.first), att.drop(1))
		else
			return obj.send(*att)
		end
	end

end