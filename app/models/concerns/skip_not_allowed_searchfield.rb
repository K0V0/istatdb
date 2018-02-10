=begin
module SkipNotAllowedSearchfield
	extend ActiveSupport::Concern

	def self.included(base)
		attr_accessor :allow_search_as_new
	end

	def skip_deactivated_fields_for(*assocs)
		assocs.each do |assoc|
			if assoc.to_s.is_singular?
				logger(self.send("#{assoc.to_s}_id"), "localtric id")
				logger(self.send("#{assoc.to_s}"), "localtric assoc")
				# dava stale id
				# dava stale assoc
				if self.send("#{assoc.to_s}").try(:allow_search_as_new) == "0"
					self.send("#{assoc.to_s}").delete
					# zmaze aj vybrany taric kod
				end


			else
				self.send(assoc).each do |a|
					if a.id.blank?
						if a.try(:allow_search_as_new) == "0"
							a.delete
						end
					end
				end
			end
		end
	end

end
=end