module Defaults
	extend ActiveSupport::Concern

	def self.included(base)
	  base.instance_eval do 

	  	scope :default_order, -> { 
			order(id: :asc)
		}

	  	scope :order_this_id_first, -> (pars) { 
			order_as_specified(id: [pars])
			.default_order
		}

	  end
	end
	

end