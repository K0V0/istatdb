class Good < ActiveRecord::Base

	attr_accessor :kn_code
	attr_accessor :kn_code_description
	attr_accessor :client
	attr_accessor :client_office
	attr_accessor :manufacturer_name

	# cannot use accept_nested_attributes_for due to fact that when user in this model 
	# writes something that is in database I want to associate it only
	# what can not be done when validations fail
	# cannot use second solution to validate on parent model because each association 
	# here can be added independently from other places in app and validations 
	# on both sides causes circular dependency error

	has_many :goods_manufacturers, inverse_of: :good
	has_many :manufacturers, through: :goods_manufacturers

	has_many :goods_impexpcompanies, inverse_of: :good
	has_many :impexpcompanies, through: :goods_impexpcompanies

	belongs_to :local_taric

	validates :ident, presence: true
	validates :ident, uniqueness: true

	validate :kn_code_validation
	validate :client_validation
	#validate :manufacturer_validation

	after_create :assignments

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

	def client_validation
		assoc_validator( Impexpcompany, { 
			company_name: @client, 
			affiliated_office: @client_office
		})
	end

	def manufacturer_validation
		assoc_validator( Manufacturer, { 
			name: @manufacturer_name
		})
	end

	def assignments
		@local_taric.goods << self
		@impexpcompany.goods << self
		#@manufacturer.goods << self
	end

	def assoc_validator object, fields={}
		tmp = object.where(fields)
		if !tmp.blank?
			# is also in DB, so will be valid
			instance_variable_set('@'+object.to_s.singularize.underscore, tmp.first)
		else
			# uniqueness validation condition bypassed by validating on new object
			# object is unique because by given criteria not found ind DB
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
