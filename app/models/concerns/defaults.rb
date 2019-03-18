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

		# precuje len pre many to many assoc
		scope :load_checked_first, -> (pars) {
			items_per_page = pars.page(1).limit_value
			items_checked = pars.size
			checked_ids = pars.pluck(:id)
			next_ids = []

			if !pars.nil?
				if (new_items_to_load = items_per_page - items_checked) > 0
					next_ids = self.default_order.where.not(id: checked_ids).limit(new_items_to_load).pluck(:id)
				end
			end

			self.where(id: (checked_ids + next_ids)).order_as_specified(id: (checked_ids + next_ids))
		}

	  end
	end

end


