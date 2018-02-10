module NestedAttributesGetterConcern
	extend ActiveSupport::Concern

	self.included do

	end

	module ClassMethods
		
		def nested_attrs_getter_for(*assocs)
			assocs.each do |a|

				#ids_method_name = a.to_s.is_singular? ? "" : "#{a.to_s.singularize}_ids"
				ids_method_name = "#{a.to_s.singularize}_id"
				ids_method_name += "s" if !a.to_s.is_singular?
				attrs_method_name = "#{a.to_s}_attributes"

				define_method "#{ids_method_name}=" do |arg|
					# gets associated_ids (checked checkboxes ids)
					#logger arg, "getter for arg"
					filtered_arr = case arg
					when String
						# singular assoc
						arg
					else
					 	arg.select { |a| !a.blank? }
					end
					instance_variable_set("@#{ids_method_name}", filtered_arr)
					logger(arg, "arg ids_method_name")
					super arg
				end

				#define_method ids_method_name do
				#	instance_variable_get("@#{ids_method_name}")
				#end
				# nemoze byt pouzite

				define_method "#{attrs_method_name}=" do |arg|
					# monkey fix - when in second and other form input repeat after validation fail
					# the attributes with deselected ids are passed into nested_attributes
					# params hash example: {"0"=>{"id"=>"5"}, "1"=>{"id"=>"6"}} (has_many assoc)
					#logger arg
					#logger arg.try(:[], "0")

					if arg.try(:[], "0").blank?
						# is in belongs_to (singular) assoc
						instance_variable_set("@#{attrs_method_name}", arg)
						logger arg, "attrs for super" 
						super arg#.dup.except!(:allow_search_as_new)
						# if form posted with allowed add as new, program fails 
					else
						if self.id.blank?
							tmp = Hash.new
							tmp["0"] = arg.to_a.last[1]
							#logger(tmp["0"])
							instance_variable_set("@#{attrs_method_name}", arg)
							super tmp
						else
							ids_checked = instance_variable_get("@#{ids_method_name}")

							arg.each do |k, v|
								if v.keys.first.to_s == "id"
									if !ids_checked.include? v[:id]
										arg.except!(k)
									end
								end
							end
							
							instance_variable_set("@#{attrs_method_name}", arg)
							super arg
						end
					end
				end

				define_method attrs_method_name do
					instance_variable_get("@#{attrs_method_name}")
				end
			end
		end
	end

end