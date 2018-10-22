class Manufacturer < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults
	include NestedAttributesGetterConcern

	has_many :intertables, inverse_of: :manufacturer, dependent: :destroy
	has_many :goods, through: :intertables

	has_many :impexpcompany_manufacturers, inverse_of: :manufacturer, dependent: :destroy
	accepts_nested_attributes_for(
		:impexpcompany_manufacturers,
		reject_if: lambda { |c| c[:id].blank? }
	)

	has_many :impexpcompanies, through: :impexpcompany_manufacturers
	accepts_nested_attributes_for(
		:impexpcompanies,
		reject_if: lambda { |c| c[:company_name].blank? }
	)

	has_many :uoms, inverse_of: :manufacturer

	validates :name, presence: true
	validates :name, uniqueness: true

	nested_attrs_getter_for :impexpcompanies, :local_taric
	# for some reason needs to be present when editing manufacturer
	# i do not remember why i do this monkey patch
	# and removing one or more impexpcompanies (associations) from it

	scope :default_order, -> {
		order(name: :asc)
	}

	scope :preload_items, -> {
		Manufacturer.preload(impexpcompany_manufacturers: [:incoterm, :impexpcompany, local_taric: [:translations]]).default_order
	}

	scope :impexpcompany_filter, -> (pars) {
		self
		.joins(:impexpcompanies)
		.where(impexpcompanies: {
			id: pars
		})
		.preload(:impexpcompanies)
	}

	def self.ransackable_scopes(*pars)
	    %i(impexpcompany_filter)
	end

end
