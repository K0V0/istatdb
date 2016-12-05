class Manufacturer < ActiveRecord::Base

	has_many :goods_manufacturers, inverse_of: :manufacturer
	has_many :goods, through: :goods_manufacturers

	has_many :impexpcompany_manufacturers, inverse_of: :manufacturer
	has_many :impexpcompanies, through: :impexpcompany_manufacturers 

	validates :name, presence: true
	validates :name, uniqueness: true
	
end
