class Impexpcompany < ActiveRecord::Base

	extend OrderAsSpecified
	include Defaults

	has_many :intertables, inverse_of: :impexpcompany, dependent: :destroy
	has_many :goods, through: :intertables

	has_many :impexpcompany_manufacturers, inverse_of: :impexpcompany, dependent: :destroy
	has_many :manufacturers, through: :impexpcompany_manufacturers

	has_many :uoms, inverse_of: :impexpcompany

	has_many :good_issues, inverse_of: :impexpcompany#, dependent: :destroy
	has_many :issues, through: :good_issues

	validates :company_name, presence: true
	validates_uniqueness_of :company_name, scope: :affiliated_office

	has_many :people

	scope :default_order, -> {
		order(company_name: :asc)
	}

	def name_field
		self.company_name
	end

end
