module Defaults
	extend ActiveSupport::Concern

	include Log

	def self.included(base)
	  base.instance_eval do 

	  	attr_accessor :allow_search_as_new

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
		ok = false
		if assoc.to_s.is_singular?
			logger(self.send("#{assoc.to_s}_attributes"), "assoc attrs #{assoc.to_s}")
			logger(self.send("#{assoc.to_s}_id"), 'assoc id')
			logger(self.send(assoc).try(field), 'try field')
			logger(self.send(assoc).try(:id), 'try id')
			logger(self.send(:local_taric_id), 'try id')
			logger(@local_taric_id, 'try id @')
			sth_in_inputfields = self.send("#{assoc.to_s}_attributes")[:allow_search_as_new] == "1"
			#sth_selected = !self.send("@#{assoc.to_s}_id").blank?
			sth_selected = !instance_variable_get("@#{assoc.to_s}_id").blank?
			logger(sth_in_inputfields, "sth_in_inputfields")
			logger(sth_selected, "sth_selected")
			if sth_selected || sth_in_inputfields
				ok = true
			end
		else
			a = self.send("#{assoc.to_s}_attributes").map { |k,v| v[field] }
			ok = !((!self.send("#{assoc.to_s.singularize}_ids").any?)&&(a.all?(&:blank?)))
		end
		ok
	end
	
end


