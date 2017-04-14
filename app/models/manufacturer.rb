class Manufacturer < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults
	#include AssocValidator

	#has_many :goods_manufacturers, inverse_of: :manufacturer
	#has_many :goods, through: :goods_manufacturers

	has_many :intertables, inverse_of: :manufacturer
	has_many :goods, through: :intertables

	#has_many :impexpcompany_manufacturers, inverse_of: :manufacturer
	#has_many :impexpcompanies, through: :impexpcompany_manufacturers 

	#has_many :uoms, inverse_of: :manufacturer

	#attr_accessor :impexpcompany_company_name
	#attr_accessor :local_taric_kncode
	#attr_accessor :local_taric_description
	#attr_writer :incoterm

	validates :name, presence: true
	validates :name, uniqueness: true

	#validate :associated_validations, on: :create

	#after_create :assignments

	scope :default_order, -> { 
		order(name: :asc)
	}

	def intrastat_clients
		#impexpcompany_manufacturers.collect { |w|
		#	w.impexpcompany.company_name
		#}
	end

	def	taric_codes
		#impexpcompany_manufacturers.collect { |w|
		#	tmp = w.local_taric.try(:kncode)
		#	tmp.blank? ? "---" : tmp
		#}
	end

	def incoterm
	end

	def incoterm_shortlands
		#impexpcompany_manufacturers.collect { |w|
		#	term = Incoterm.find(w.try(:incoterm));
		#	term.blank? ? "---" : term.shortland
		#}
	end

	scope :impexpcompany_filter, -> (pars) { 
		self
		.joins(:impexpcompanies)
		.where(impexpcompanies: { 
			id: pars 
		})
		.preload(:impexpcompanies, :goods)
	}

	def self.ransackable_scopes(*pars)
	    %i(impexpcompany_filter)
	end

	
	
end
