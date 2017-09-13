module SkipNotAllowedSearchfield
	extend ActiveSupport::Concern

	def self.included(base)
		attr_accessor :allow_search_as_new
	end

	def skip_deactivated_fields_for(*assocs)
		assocs.each do |assoc|
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