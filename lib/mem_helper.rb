module MemHelper

	def init_mem
		@MEM = Mem.new(session) if !defined? @MEM
	end

	def setting setting_key
		if !user_signed_in?
			return Setting.d.send(setting_key)
		else
			if !@MEM.settings.nil?||@MEM.nil?
				return @MEM.settings.send(setting_key)
			else
				init_mem
				@MEM.settings = current_user.settings.l
				return @MEM.settings.send(setting_key)
			end
		end
	end

	def setting_is_set? setting_key
		isset = setting(setting_key)
		if (isset == "1")||(isset == true)
			return true
		else
			return false
		end
	end

end