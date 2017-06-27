module NestedAttributesGetterConcern
	extend ActiveSupport::Concern

	self.included do

	end

	module ClassMethods
		
		def nested_attrs_getter_for(*assocs)
			assocs.each do |a|
				method_name = "#{a.to_s}_attributes"

				define_method "#{method_name}=" do |arg|
					# monkey fix - when in second and other form input repeat after validation fail
					# the attributes with deselected ids are passed into nested_attributes
					tmp = Hash.new
					tmp["0"] = arg.to_a.last[1]
					instance_variable_set("@#{method_name}", arg)
					super tmp
				end

				define_method method_name do
					instance_variable_get("@#{method_name}")
				end
			end
		end
	end


end