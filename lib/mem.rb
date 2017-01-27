class Mem

	def initialize session
		@session = session
		@session["MEM"] ||= Marshal::dump(MemData.new)
		@totok = nil
		@matches = nil
	end

	def method_missing(method_sym, *arguments, &block)
	  	if (@matches = /^(\w*)=$/.match method_sym)
	  		load
	  		@totok[@matches[1].to_sym] = arguments[0]
	  		set
	  	elsif (method_sym =~ /^(\w+)$/)
	  		load
	  		return @totok[method_sym]
	  	elsif (method_sym =~ /^=$/)
	  		if arguments[0].is_a? Hash
	  			load
	  			arguments[0].each do |arg, val|
	  				@totok[arg] = val
	  			end
	  			set
	  		end
=begin
	  	elsif (@matches = /^(\w+)\[[\:|\"]{1}(\w+)\"?\]$/.match method_sym)
	  		load
	  		Rails.logger.info "========= kokoooot"
	  		return @totok[@matches[1]][@matches[2]]
	  		#return @totok[@matches[1]]
	  	elsif (matches = /^(\w+)\[[\:|\"]{1}(\w+)\"?\]=$/.match method_sym)
	  		load
	  		@totok[@matches[1]][@matches[2]] = arguments[0]
	  		#@totok[@matches[1]] = { @matches2.to_sym => arguments[0] }
	  		#@totok
	  		set
=end
	  	else
	  		#
	  	end
	end

	private

	def load
		@totok = Marshal::load(@session["MEM"])
	end

	def set
		@session["MEM"] = Marshal::dump(@totok)
	end

end

class MemData < OpenStruct
	
end