class Manufacturer < ActiveRecord::Base

	has_many :goods_manufacturers, inverse_of: :manufacturer
	has_many :goods, through: :goods_manufacturers
	
end
