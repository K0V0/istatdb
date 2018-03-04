class LocalTaric < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults

	translates :description

	has_many :goods, inverse_of: :local_taric

	has_many :impexpcompany_manufacturers, inverse_of: :local_taric

	validates :kncode, presence: true
	validates :kncode, numericality: { only_integer: true }
	validate :kncode_length_valid

	validates :description, presence: true
	validates_uniqueness_of :kncode, scope: :description

	def kncode_length_valid
		if !kncode.nil?
		## added because of some reason if presence validations fails
		## other validations continues too
			if !(kncode.length == 8 || kncode.length == 10)
				errors.add(:kncode, :not_exactly_8_or_10)
			end
		end
	end

	scope :default_order, -> {
		#with_translations(I18n.locale)
		order(kncode: :asc)
	}

end
