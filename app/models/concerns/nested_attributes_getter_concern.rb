module NestedAttributesGetterConcern
	extend ActiveSupport::Concern

	self.included do

	end

	module ClassMethods
		
		def nested_attrs_getter_for(*assocs)
			assocs.each do |a|
				method_name = "#{a.to_s}_attributes"

				define_method "#{method_name}=" do |arg|
					instance_variable_set("@#{method_name}", arg)
					super arg
				end

				define_method method_name do
					instance_variable_get("@#{method_name}")
				end
			end
		end
	end


end