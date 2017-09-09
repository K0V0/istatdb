class Manufacturer < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults

	has_many :intertables, inverse_of: :manufacturer, dependent: :destroy
	has_many :goods, through: :intertables

	has_many :impexpcompany_manufacturers, inverse_of: :manufacturer, dependent: :destroy
	has_many :impexpcompanies, through: :impexpcompany_manufacturers 

	has_many :uoms, inverse_of: :manufacturer

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

	scope :preload_items, -> { 
		Manufacturer.preload(goods: [:impexpcompanies])
	}

	#def intrastat_clients
		#self.goods.uniq.collect { |w| w.impexpcompanies.collect { |q| q.company_name } }.flatten.uniq
	#end

	def goods_count
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
