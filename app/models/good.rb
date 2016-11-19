class Good < ActiveRecord::Base

	include AssocValidator
	include AssocFillup

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

	belongs_to :local_taric, inverse_of: :goods

	validates :ident, presence: true
	validates :ident, uniqueness: true

	validate :associated_validations, on: :create

	after_create :assignments
	before_update :kn_code_update
	after_initialize :fillup_virtual_params

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

	def fillup_virtual_params
		#self.fillup_virtual :local_taric, fields: [:kncode, :description]
		self.class.send(:define_method, :local_taric_kncode) do
	      instance_variable_set('@local_taric_kncode', 'AAAA')
	    end
	end

	def associated_validations
		assoc_validator LocalTaric, :kncode, :description
		assoc_validator Impexpcompany, :company_name
		assoc_validator Manufacturer, :name
	end

	def assignments
		@local_taric.goods << self
		@impexpcompany.goods << self
		@manufacturer.goods << self
	end

	def kn_code_update
		l = LocalTaric.find_or_create_by(kncode: @local_taric_kncode, description: @local_taric_description)
		Rails.logger.info "--------------"
		Rails.logger.info l.id
		Rails.logger.info self.local_taric.id
		if l.id == self.local_taric.id

		else
			self.local_taric = l
		end
		
		#Rails.logger.info self.local_taric.update(kncode: @local_taric_kncode)
	end

	#def self.fillup_virtual(assoc_name, fields: [])
		#fields.each do |field|
		#	make_verbose_getter assoc_name.to_s+'_'+field.to_s
		#end
	#end

end
