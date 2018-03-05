class Incoterm < ActiveRecord::Base

	include Defaults

    translates :description

	has_many :impexpcompany_manufacturers, -> { distinct }, inverse_of: :incoterm

	scope :default_order, -> {
		order(shortland: :asc)
	}

end
