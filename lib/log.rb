class Log

	def log something="log", var=nil
		Rails.logger.info "-------------- " + something.to_s
		Rails.logger.info var
	end
end