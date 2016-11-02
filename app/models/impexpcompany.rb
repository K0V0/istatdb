class Impexpcompany < ActiveRecord::Base

	has_many :goods_impexpcompanies, inverse_of: :impexpcompany 
	has_many :goods, through: :goods_impexpcompanies

	validates :company_name, presence: true
	validates :company_name, uniqueness: true

end
