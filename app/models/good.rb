class Good < ActiveRecord::Base

	# convention: <associated model name><underscore><field name in assoc model>
	attr_accessor :local_taric_kncode
	attr_accessor :local_taric_description
	attr_accessor :impexpcompany_company_name
	attr_accessor :impexpcompany_affiliated_office
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
	validate :manufacturer_validation

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
		assoc_validator LocalTaric, :kncode, :description
	end

	def client_validation
		assoc_validator Impexpcompany, :company_name
	end

	def manufacturer_validation
		assoc_validator Manufacturer, :name
	end

	def assignments
		@local_taric.goods << self
		@impexpcompany.goods << self
		@manufacturer.goods << self
	end

	def assoc_validator object, *fields
		query = {}
		mdl = object.to_s.underscore
		instvar_string = '@' + mdl

		fields.each do |field|
			query[field] = instance_variable_get(instvar_string + '_' + field.to_s)
		end

		tmp = object.where(query)
		if !tmp.blank?
			# is also in DB, so will be valid
			instance_variable_set(instvar_string, tmp.first)
		else
			# uniqueness validation condition bypassed by validating on new object
			# object is unique because by given criteria not found ind DB
			tmp = object.new(query)
			if !tmp.valid?
				errors.add(
					(mdl + '_' + fields.last.to_s).to_sym,
					tmp.errors.to_a.first
				) 
			else
				instance_variable_set(instvar_string, tmp)
				instance_variable_get(instvar_string).send(:save)
			end
		end
	end
	
end
