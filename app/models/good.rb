class Good < ActiveRecord::Base

	include AssocValidator
	include AssocValidatorUoms
	include AssocFillup

	# convention: <associated model name><underscore><field name in assoc model>
	#attr_accessor :search_both
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

	def uoms
		 @uoms ||= [{ uom: "", uom_multiplier: "1", uom_type_id: "" }]
	end

	def uoms=(par)
		@uoms = par
	end

	def kncode
		local_taric.kncode
	end

	def kncode_description
		local_taric.description
	end

	has_many :goods_manufacturers, inverse_of: :good
	has_many :manufacturers, through: :goods_manufacturers

	has_many :goods_impexpcompanies, inverse_of: :good
	has_many :impexpcompanies, through: :goods_impexpcompanies

	belongs_to :local_taric, inverse_of: :goods

	validates :ident, presence: true
	#validate :unique_by_assocs, on: :create
	validate :associated_validations, on: :create
	validate :unique_by_assocs

	after_initialize :fillup_virtual_params
	before_update :kn_code_update
	before_save :stop_save
	after_create :assignments#, if: :stop_save

	scope :impexpcompany_filter, -> (pars) { 
		self
		.includes(:impexpcompanies)
		.where(impexpcompanies: { 
			id: pars 
		})
		.references(:impexpcompanies)
	}

	scope :manufacturer_filter, -> (pars) { 
		self
		.includes(:manufacturers)
		.where(manufacturers: { 
			id: pars 
		})
		.references(:manufacturers)
	}

	def self.ransackable_scopes(*pars)
	    %i(impexpcompany_filter manufacturer_filter)
	end

	## resolve how to run from update action only - maybe run from controller
	def fillup_virtual_params
		#fillup_virtual :local_taric, fields: [:kncode, :description]
	end

	def stop_save
		return !@skip_assoc_after_create
	end

	def unique_by_assocs
		res = Good.where(ident: ident).first
		Rails.logger.info "---------------"
		#Rails.logger.info res.ident
		#Rails.logger.info self
		if !res.nil?
			Rails.logger.info "not nil---------------"
			@current = res
			@current.assign_attributes({
				local_taric_kncode: local_taric_kncode,
				local_taric_description: local_taric_description,
				impexpcompany_company_name: impexpcompany_company_name,
				manufacturer_name: manufacturer_name
			})
			@skip_taric = true
			assignments
			@skip_assoc_after_create = true
		else
			
			@skip_taric = false
			@skip_assoc_after_create = false
			@current = self
			#Rails.logger.info self
		end
	end

	def associated_validations
		assoc_validator LocalTaric, :kncode, :description
		assoc_validator Impexpcompany, :company_name
		assoc_validator Manufacturer, :name
		assoc_validator_uoms @uoms
	end

	def assignments
		#self.local_taric_id = @local_taric.id
		#self.impexpcompanies << @impexpcompany
		#self.manufacturers << @manufacturer
		#(@local_taric.goods << @current) if @skip_taric == false 
		@current.local_taric_id = @local_taric.id
		@current.save
		#@local_taric.goods << @current
		@impexpcompany.goods << @current
		@manufacturer.goods << @current
		# this search should always return unique one result 
		gm = @manufacturer.goods_manufacturers.where(good_id: @current.id).first.uoms
		@uoms.each do |uom|
			gm << Uom.new(uom)
		end
		ImpexpcompanyManufacturer.create(
			manufacturer_id: @manufacturer.id,
			impexpcompany_id: @impexpcompany.id
		)
	end

	def kn_code_update
		l = LocalTaric.find_or_create_by(kncode: @local_taric_kncode, description: @local_taric_description)
		if l.id == self.local_taric.id

		else
			self.local_taric = l
		end
	end

end