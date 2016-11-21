class LocalTaric < ActiveRecord::Base

	has_many :goods, inverse_of: :local_taric

	validates :kncode, presence: true
	validates :kncode, numericality: { only_integer: true }
	validate :kncode_length_valid

	validates :description, presence: true
	validates_uniqueness_of :kncode, scope: :description#, on: :create

	def kncode_length_valid
		if !kncode.nil?
			if !(kncode.length == 8 || kncode.length == 10)
				errors.add(:kncode, :exactly)
			end
		end
	end
	
end
