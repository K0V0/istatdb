class TradeType < ActiveRecord::Base

    translates :description

    has_many :impexpcompany_manufacturers, inverse_of: :trade_type

	self.inheritance_column = nil

	scope :default_order, -> {
		order(type: :asc)
	}

    validates :type, presence: true

end
