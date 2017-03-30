class Good < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults
	include Log

	has_many :intertables, inverse_of: :good

	has_many :manufacturers, -> { distinct }, through: :intertables

	has_many :impexpcompanies, -> { distinct }, through: :intertables
	accepts_nested_attributes_for :impexpcompanies

	belongs_to :local_taric, inverse_of: :goods
	accepts_nested_attributes_for :local_taric, reject_if: :local_taric_selected

	validates :ident, presence: true


	def local_taric_selected
		## if is kncode selected from list (radio buttons) ignores text fields
		!self.local_taric_id.blank?
	end

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

end