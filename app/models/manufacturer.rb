class Manufacturer < ActiveRecord::Base

	has_many :goods_manufacturers, inverse_of: :manufacturer
	has_many :goods, through: :goods_manufacturers

	has_many :impexpcompany_manufacturers, inverse_of: :manufacturer
	has_many :impexpcompanies, through: :impexpcompany_manufacturers 

	validates :name, presence: true
	validates :name, uniqueness: true

	attr_accessor :impexpcompany_company_name
	attr_accessor :local_taric_kncode
	attr_accessor :local_taric_description
	
end
