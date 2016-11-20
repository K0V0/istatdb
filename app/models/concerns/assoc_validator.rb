module AssocValidator
	extend ActiveSupport::Concern

	def self.included(base)
	  base.extend(ClassMethods)
	end

	module ClassMethods 
		 
	end

  	def assoc_validator object, *fields
		query = {}
		mdl = object.to_s.underscore
		instvar_string = '@' + mdl

		fields.each do |field|
			query[field] = instance_variable_get(instvar_string + '_' + field.to_s)
		end

		tmp = object.where(query)
		if !tmp.blank?
			# is also in DB, so will be valid
			instance_variable_set(instvar_string, tmp.first)
		else
			# uniqueness validation condition bypassed by validating on new object
			# object is unique because by given criteria not found ind DB
			tmp = object.new(query)
			if !tmp.valid?
				errors.add(
					(mdl + '_' + fields.last.to_s).to_sym,
					tmp.errors.to_a.first
				) 
			else
				instance_variable_set(instvar_string, tmp)
				instance_variable_get(instvar_string).send(:save)
			end
		end
	end

end