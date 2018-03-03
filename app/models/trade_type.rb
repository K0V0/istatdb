class TradeType < ActiveRecord::Base

    has_many :impexpcompany_manufacturers, inverse_of: :trade_type

	self.inheritance_column = nil

	scope :default_order, -> {
		order(type: :asc)
	}
end
