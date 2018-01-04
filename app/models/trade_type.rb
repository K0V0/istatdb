class TradeType < ActiveRecord::Base

	scope :default_order, -> { 
		order(type: :asc)
	}
end
