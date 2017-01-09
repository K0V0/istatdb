class Mem

	def initialize session
		@session = session
		@session["MEM"] ||= Marshal::dump(MemData.new)
	end

	def method_missing(method_sym, *arguments, &block)
	  	if (method_sym =~ /^(\w*)=$/)
	  		tmp = Marshal::load(@session["MEM"])
	  		tmp[method_sym.to_s.sub("=", "").to_sym] = arguments[0]
	  		@session["MEM"] = Marshal::dump(tmp)
	  	elsif (method_sym =~ /^(\w+)$/)
	  		return Marshal::load(@session["MEM"])[method_sym]
	  	elsif (method_sym =~ /^=$/)
	  		if arguments[0].is_a? Hash
	  			tmp = Marshal::load(@session["MEM"])
	  			arguments[0].each do |arg, val|
	  				tmp[arg] = val
	  			end
	  			@session["MEM"] = Marshal::dump(tmp)
	  		end
	  	end
	end

	def data 
		Marshal::load(@session["MEM"])
	end

	def clear
		@session["MEM"] = Marshal::dump(MemData.new)
	end

end

class MemData < OpenStruct
	
end