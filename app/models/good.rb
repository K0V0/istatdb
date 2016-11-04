class Good < ActiveRecord::Base

	attr_accessor :kn_code
	attr_accessor :kn_code_description

	has_many :goods_manufacturers, inverse_of: :good
	has_many :manufacturers, through: :goods_manufacturers

	has_many :goods_impexpcompanies, inverse_of: :good
	has_many :impexpcompanies, through: :goods_impexpcompanies

	belongs_to :local_taric

	validates :ident, presence: true
	validates :ident, uniqueness: true

	validate :kn_code_validation

	scope :client_filter, -> (pars) { 
		self
		.joins(:impexpcompanies)
		.where(impexpcompanies: { 
			id: pars 
		})
	}

	def self.ransackable_scopes(*pars)
	    %i(client_filter)
	end

	def kn_code_validation
		tmp = LocalTaric.new(kncode: @kn_code, description: @kn_code_description)
		if !tmp.valid?
			errors.add(:kn_code, tmp.errors.to_a.first) 
		end
	end
	
end
