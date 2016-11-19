module AssocFillup
	extend ActiveSupport::Concern
=begin
	def fillup_virtual(assoc_name, fields: [])
		fields.each do |field|
			make_verbose_getter assoc_name.to_s+'_'+field.to_s
		end
	end

	def make_verbose_getter(*names)
	 	names.each do |name|
	 		if !self.send(name).nil?
	 			Rails.logger.info "--------------"

	 		end
	    	define_method("#{name}") do |val|
	      		#puts "@#{name} was set to #{val}"
	        	instance_variable_set("@#{name}", val)
	      	end
	    end
	end
=end
=begin
	def make_verbose_setter(*names)
	 	names.each do |name|
	    	define_method("#{name}=") do |val|
	      		#puts "@#{name} was set to #{val}"
	        	#instance_variable_set("@#{name}", val)
	      	end
	    end
	end

	def local_taric_kncode
		@local_taric_kncode ||= self.local_taric.kncode if !self.local_taric.nil?
	end
=end

	module ClassMethods 

		def fillup_virtual(assoc_name, fields: [])
			fields.each do |field|
				make_verbose_getter assoc_name.to_s+'_'+field.to_s
			end
		end
	end

	def self.included(base)
	  base.extend(ClassMethods)
	end

end