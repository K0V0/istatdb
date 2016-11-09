class LocalTaric < ActiveRecord::Base

	has_many :goods 

	validates :kncode, presence: true
	validates :kncode, numericality: { only_integer: true }
	validate :kncode_length_valid

	validates :description, presence: true
	validates_uniqueness_of :kncode, scope: :description

	def kncode_length_valid
		if !(kncode.length == 8 || kncode.length == 10)
			errors.add(:kncode, :exactly)
		end
	end

end
