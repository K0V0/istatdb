class Mem

	@@mem_data = nil

	def initialize
		@@mem_data = MemData.new if @@mem_data.nil?
	end

	def method_missing(method_sym, *arguments, &block)
	  	if (method_sym =~ /^(\w*)=$/)
	  		return @@mem_data[method_sym.to_s.sub("=", "").to_sym] = arguments[0]
	  	elsif (method_sym =~ /^(\w*)$/)
	  		return @@mem_data[method_sym]
	  	elsif (method_sym =~ /^=$/)
	  		if arguments[0].is_a? Hash
	  			arguments[0].each do |arg, val|
	  				@@mem_data[arg] = val
	  			end
	  		end
	  	end
	end

	def data 
		@@mem_data
	end

	def clear
		@@mem_data = MemData.new
	end

end

class MemData < OpenStruct
	
end