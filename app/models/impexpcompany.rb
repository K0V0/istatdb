class Impexpcompany < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults

	has_many :goods_impexpcompanies, inverse_of: :impexpcompany 
	has_many :goods, through: :goods_impexpcompanies

	has_many :impexpcompany_manufacturers, inverse_of: :impexpcompany
	has_many :manufacturers, through: :impexpcompany_manufacturers

	validates :company_name, presence: true
	validates_uniqueness_of :company_name, scope: :affiliated_office

	scope :default_order, -> { 
		order(company_name: :asc)
	}

end
