class LocalTaric < ActiveRecord::Base

	has_many :goods 

	validates :kncode, presence: true
	validates :kncode, numericality: { only_integer: true }
	validates :kncode, length: { in: 8..10 }

	validates :description, presence: true

end
