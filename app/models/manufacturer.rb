class Manufacturer < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults

	has_many :intertables, inverse_of: :manufacturer, dependent: :destroy
	has_many :goods, through: :intertables

	has_many :impexpcompany_manufacturers, inverse_of: :manufacturer, dependent: :destroy
	has_many :impexpcompanies, through: :impexpcompany_manufacturers 

	has_many :uoms, inverse_of: :manufacturer

	validates :name, presence: true
	validates :name, uniqueness: true

	scope :default_order, -> { 
		order(name: :asc)
	}

	scope :preload_items, -> { 
		Manufacturer.preload(goods: [:impexpcompanies], impexpcompany_manufacturers: [:incoterm])
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
