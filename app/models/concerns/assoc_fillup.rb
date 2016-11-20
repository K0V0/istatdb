module AssocFillup
	extend ActiveSupport::Concern

	def fillup_virtual(model_name, fields: [])
		fields.each do |field|
			name = model_name.to_s + '_' + field.to_s
			self.class.send(:define_method, name) do
				if !self.send(model_name).nil?
					assocs = self.send(model_name).send(field)
			      	instance_variable_set('@'+name, assocs)
			    end
		    end
		end
	end

	module ClassMethods 

		
	end

	def self.included(base)
	  base.extend(ClassMethods)
	end

end