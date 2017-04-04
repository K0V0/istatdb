class Good < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults
	include NestedAttributesGetterConcern
	include Log

	has_many :intertables, inverse_of: :good

	has_many :manufacturers, -> { distinct }, through: :intertables
	accepts_nested_attributes_for :manufacturers

	has_many :impexpcompanies, -> { distinct }, through: :intertables
	accepts_nested_attributes_for :impexpcompanies#, reject_if: :at_least_one_impexpcompany_selected

	belongs_to :local_taric, inverse_of: :goods
	accepts_nested_attributes_for :local_taric, reject_if: :local_taric_selected

	nested_attrs_getter_for :manufacturers, :impexpcompanies
	## monkey patch for having <associated>_attributes getter and instance variable
	## from model itself when using accept_nested_attributes_for

	validates :ident, presence: true
	#validates :ident, uniqueness: true
	validate :at_least_one_impexpcompany_selected
	validate :at_least_one_manufacturer_selected

	scope :default_order, -> { 
		order(ident: :asc)
	}

	scope :impexpcompany_filter, -> (pars) { 
		self
		.includes(:impexpcompanies)
		.where(impexpcompanies: { 
			id: pars 
		})
		.references(:impexpcompanies)
	}

	scope :manufacturer_filter, -> (pars) { 
		self
		.includes(:manufacturers)
		.where(manufacturers: { 
			id: pars 
		})
		.references(:manufacturers)
	}

	def self.ransackable_scopes(*pars)
	    %i(impexpcompany_filter manufacturer_filter)
	end

	def local_taric_selected
		## if is kncode selected from list (radio buttons) ignores text fields
		## execution halted when returned true
		!self.local_taric_id.blank?
	end

	def at_least_one_impexpcompany_selected
		if nested_selected_or_created_any?(:impexpcompanies, :company_name)
		## returns true if nothong found
		## check if parent has at least one association (persisted or newly created)
			self.errors.add(:impexpcompanies_attributes, :not_selected_or_created)
		end
	end

	def at_least_one_manufacturer_selected
		if nested_selected_or_created_any?(:manufacturers, :name)
			self.errors.add(:impexpcompanies_attributes, :not_selected_or_created)
		end
	end

end