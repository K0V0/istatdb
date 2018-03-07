class LocalTaric < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults

	translates :description#, touch: true

	has_many :goods, inverse_of: :local_taric

	has_many :impexpcompany_manufacturers, inverse_of: :local_taric

	validates :kncode, presence: true
	validates :kncode, numericality: { only_integer: true }
	validate :kncode_length_valid
	validates_presence_of :description
	validate :record_identical

	def record_identical
		if LocalTaric.exists?(kncode: self.kncode, description: self.description)
			errors.add(:description, :not_unique)
		end
	end

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
		order(kncode: :asc)
	}

end
