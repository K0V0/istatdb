class Good < ActiveRecord::Base

	attr_accessor :kn_code
	attr_accessor :kn_code_description
	attr_accessor :client
	attr_accessor :client_office
	attr_accessor :manufacturer

	has_many :goods_manufacturers, inverse_of: :good
	has_many :manufacturers, through: :goods_manufacturers

	has_many :goods_impexpcompanies, inverse_of: :good
	has_many :impexpcompanies, through: :goods_impexpcompanies

	belongs_to :local_taric

	validates :ident, presence: true
	validates :ident, uniqueness: true

	validate :kn_code_validation
	after_create :assign_to_taric

	validate :client_validation
	after_create :assign_to_client

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
		assoc_validator( LocalTaric, { 
			kncode: @kn_code, 
			description: @kn_code_description 
		})
	end

	def assign_to_taric
		@local_taric.goods << self
	end

	def client_validation
		assoc_validator( Impexpcompany, { 
			company_name: @client, 
			affiliated_office: @client_office
		})
	end

	def assign_to_client
		@impexpcompany.goods << self
	end

	def assoc_validator object, fields={}
		tmp = object.where(fields)
		if !tmp.blank?
			# nachadza sa v DB takze bude valid
			instance_variable_set('@'+object.to_s.singularize.underscore, tmp.first)
		else
			# nutne obidenie validacej podmienky na unikatnost
			tmp = object.new(fields)
			if !tmp.valid?
				errors.add(fields.last.key, tmp.errors.to_a.first) 
			else
				instance_variable_set('@'+object.to_s.singularize.underscore, tmp)
				'@'+object.to_s.singularize.underscore.constantize.send(:save)
			end
		end
	end
	
end
