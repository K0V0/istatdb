class Manufacturer < ActiveRecord::Base

	include AssocValidator

	has_many :goods_manufacturers, inverse_of: :manufacturer
	has_many :goods, through: :goods_manufacturers

	has_many :impexpcompany_manufacturers, inverse_of: :manufacturer
	has_many :impexpcompanies, through: :impexpcompany_manufacturers 

	attr_accessor :impexpcompany_company_name
	attr_accessor :local_taric_kncode
	attr_accessor :local_taric_description

	validates :name, presence: true
	validates :name, uniqueness: true

	validate :associated_validations, on: :create

	after_create :assignments

	def associated_validations
		assoc_validator(Impexpcompany, :company_name) if !@impexpcompany_company_name.blank?
		if !@local_taric_kncode.blank? || !@local_taric_description.blank?
			assoc_validator LocalTaric, :kncode, :description
		end
	end

	def assignments
		@impexpcompany.manufacturers << self if defined? @impexpcompany
		if defined? @local_taric 
			im = self.impexpcompany_manufacturers.where(impexpcompany_id: @impexpcompany.id).first
			im.local_taric_id = @local_taric.id
			im.save
		end
	end
	
end
