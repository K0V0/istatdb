module Defaults
	extend ActiveSupport::Concern

	include Log


	def self.included(base)
	  base.instance_eval do

	  	attr_accessor :allow_search_as_new
	  	attr_accessor :only_one

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

end


