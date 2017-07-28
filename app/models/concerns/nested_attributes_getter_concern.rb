module NestedAttributesGetterConcern
	extend ActiveSupport::Concern

	self.included do

	end

	module ClassMethods
		
		def nested_attrs_getter_for(*assocs)
			assocs.each do |a|

				ids_method_name = "#{a.to_s.singularize}_ids"
				attrs_method_name = "#{a.to_s}_attributes"

				define_method "#{ids_method_name}=" do |arg|
					# gets associated_ids (checked checkboxes ids)
					filtered_arr = arg.select { |a| !a.blank? }
					instance_variable_set("@#{ids_method_name}", filtered_arr)
					super arg
				end

				define_method "#{attrs_method_name}=" do |arg|
					# monkey fix - when in second and other form input repeat after validation fail
					# the attributes with deselected ids are passed into nested_attributes
					# params hash example: {"0"=>{"id"=>"5"}, "1"=>{"id"=>"6"}}

					#keys_not_included = []
					#ids_checked = instance_variable_get("@#{ids_method_name}")

					#arg.each do |a|
					#	if !ids_checked.include? a[1][:id]
					#		arg.except!(a[0])
					#	end
					#end

					tmp = Hash.new
					tmp["0"] = arg.to_a.last[1]

					Rails.logger.info "----------------------"
					Rails.logger.info tmp

					instance_variable_set("@#{attrs_method_name}", arg)
					super tmp
				end

				define_method attrs_method_name do
					instance_variable_get("@#{attrs_method_name}")
				end
			end
		end
	end

end