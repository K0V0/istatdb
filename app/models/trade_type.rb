class TradeType < ActiveRecord::Base

	self.inheritance_column = nil

	scope :default_order, -> { 
		order(type: :asc)
	}
end
