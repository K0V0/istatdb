class Impexpcompany < ActiveRecord::Base

	has_many :goods_impexpcompanies, inverse_of: :impexpcompany 
	has_many :goods, through: :goods_impexpcompanies

	validates :company_name, presence: true
	validates_uniqueness_of :company_name, scope: :affiliated_office

	

end
