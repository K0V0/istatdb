module AssocValidatorUoms
	extend ActiveSupport::Concern

	def self.included(base)
	  base.extend(ClassMethods)
	end

	module ClassMethods 
		 
	end

	def assoc_validator_uoms uoms
		uoms.each_with_index do |uom, index|
			u = Uom.new(uom)
			if !u.valid?
				uom.each do |k, v|
					if !u.errors[k].blank?
						errors.add(
							'uoms_'+index.to_s,
							u.errors[k].first
						)
					end
				end
			end
		end
	end

end