module Defaults
	extend ActiveSupport::Concern

	def self.included(base)
	  base.instance_eval do 

	  	scope :order_this_id_first, -> (pars) {
	  		if !pars.blank? 
				order_as_specified(id: [pars])
				.default_order
			else
				default_order
			end
		}

		scope :persisted, -> { 
			where "#{model_name.plural}.id IS NOT NULL"
		}

	  end
	end
	
	def nested_selected_or_created_any?(assoc, field)
		a = self.send("#{assoc.to_s}_attributes").map { |k,v| v[field] }
		(!self.send("#{assoc.to_s.singularize}_ids").any?)&&(a.all?(&:blank?))
	end

end


