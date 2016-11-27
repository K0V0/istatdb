module AssocValidatorUoms
	extend ActiveSupport::Concern

	def self.included(base)
	  base.extend(ClassMethods)
	end

	module ClassMethods 
		 
	end

	

end