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
			pars = self.send("#{assoc.to_s}_attributes")
			if !pars.nil?
				inputs = pars.map { |k,v| v[field] }
				ids = self.send("#{assoc.to_s.singularize}_ids")
				enabled_to_add = self.send("#{assoc.to_s}_attributes").map { |k,v| v[:allow_search_as_new] == "1" } .any?
				any_input = !inputs.all?(&:blank?)

				if ids.nil?
					# handle app fail when searching list contains no checkboxes
					ok = true if any_input && enabled_to_add
				else
					ok = true if (any_input && enabled_to_add) || ids.any?
				end
			end
		end
		ok
	end

end
