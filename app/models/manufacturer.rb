class Manufacturer < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults
	include AssocValidator

	#has_many :goods_manufacturers, inverse_of: :manufacturer
	#has_many :goods, through: :goods_manufacturers

	has_many :intertables, inverse_of: :manufacturer
	has_many :goods, through: :intertables

	has_many :impexpcompany_manufacturers, inverse_of: :manufacturer
	has_many :impexpcompanies, through: :impexpcompany_manufacturers 

	has_many :uoms, inverse_of: :manufacturer

	attr_accessor :impexpcompany_company_name
	attr_accessor :local_taric_kncode
	attr_accessor :local_taric_description
	attr_writer :incoterm

	validates :name, presence: true
	validates :name, uniqueness: true

	validate :associated_validations, on: :create

	after_create :assignments

	scope :default_order, -> { 
		order(name: :asc)
	}

	def intrastat_clients
		impexpcompany_manufacturers.collect { |w|
			w.impexpcompany.company_name
		}
	end

	def	taric_codes
		impexpcompany_manufacturers.collect { |w|
			tmp = w.local_taric.try(:kncode)
			tmp.blank? ? "---" : tmp
		}
	end

	def incoterm
	end

	def incoterm_shortlands
		impexpcompany_manufacturers.collect { |w|
			term = Incoterm.find(w.try(:incoterm));
			term.blank? ? "---" : term.shortland
		}
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
		if defined? @impexpcompany
			im = self.impexpcompany_manufacturers.where(impexpcompany_id: @impexpcompany.id).first
			im.incoterm = @incoterm
			im.save
		end
	end
	
end
