module NestedSelectedOrCreatedAnyConcern
	extend ActiveSupport::Concern

	def self.included(base)
	  base.instance_eval do 
	  end
	end
	
	def nested_selected_or_created_any?(assoc, field)
		ok = false
		if assoc.to_s.is_singular?
			not_selected = self.send("#{assoc.to_s}_id").blank?
			textinput_disabled = self.send("#{assoc.to_s}_attributes")[:allow_search_as_new] == "0"
			if !(not_selected&&textinput_disabled)
				ok = true
			end
		else
			a = self.send("#{assoc.to_s}_attributes").map { |k,v| v[field] }
			ok = !((!self.send("#{assoc.to_s.singularize}_ids").any?)&&(a.all?(&:blank?)))
		end
		ok
	end
	
end