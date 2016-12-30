class Manufacturer < ActiveRecord::Base

	include AssocValidator

	has_many :goods_manufacturers, inverse_of: :manufacturer
	has_many :goods, through: :goods_manufacturers

	has_many :impexpcompany_manufacturers, inverse_of: :manufacturer
	has_many :impexpcompanies, through: :impexpcompany_manufacturers 

	attr_accessor :impexpcompany_company_name
	attr_accessor :local_taric_kncode
	attr_accessor :local_taric_description
	attr_writer :incoterm

	validates :name, presence: true
	validates :name, uniqueness: true

	validate :associated_validations, on: :create

	after_create :assignments

	def intrastat_clients
		impexpcompanies.collect { |w| w.company_name }
	end

	def	taric_codes
		impexpcompany_manufacturers.collect { |w| w.local_taric.try(:kncode) }
	end

	def incoterm
		#impexpcompany_manufacturers.collect { |w| "" || Incoterm.find(w.try(:incoterm)).shortland }
		#impexpcompany_manufacturers.collect { |w| Incoterm.find(w.try(:incoterm)) }
	end

	def incoterm_shortlands
		impexpcompany_manufacturers.collect { |w| 
			term = Incoterm.find(w.try(:incoterm));
			if !term.blank?
				return term.shortland
			end
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
