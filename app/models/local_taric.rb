class LocalTaric < ActiveRecord::Base

	extend OrderAsSpecified
	include Defaults

	translates :description#, touch: true
	translates :additional_info

	has_many :goods, inverse_of: :local_taric
	has_many :impexpcompany_manufacturers, inverse_of: :local_taric

	validates :kncode, presence: true
	validates :kncode, numericality: { only_integer: true }
	validate :kncode_length_valid
	validates_presence_of :description
	validate :record_identical

	before_destroy :check_if_used

	scope :default_order, -> {
		order(kncode: :asc)
	}

	private

	def record_identical
		if LocalTaric.exists?(kncode: self.kncode, description: self.description)
			if self.id.blank?
				errors.add(:description, :not_unique)
			end
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

	def check_if_used
		if goods.any? || impexpcompany_manufacturers.any?
			errors.add(:base, :is_used)
			return false
		end
	end

end
