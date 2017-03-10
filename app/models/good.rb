class Good < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults
	include AssocValidator
	include AssocValidatorUoms
	include AssocFillup
	include Log

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

	#def uoms
	#	 @uoms ||= [{ uom: "", uom_multiplier: "1", uom_type_id: "" }]
	#end

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
	has_many :manufacturers, -> { distinct }, through: :goods_manufacturers

	has_many :goods_impexpcompanies, inverse_of: :good
	has_many :impexpcompanies, -> { distinct }, through: :goods_impexpcompanies

	has_many :uoms, inverse_of: :good

	belongs_to :local_taric, inverse_of: :goods

	validates :ident, presence: true

	validate :associated_validations, on: :create
	validate :unique_by_assocs, on: :create

	validate :must_have_one_or_more_impexpcompanies, on: :update

	validate :is_on_create, on: :create
	validate :is_on_update, on: :update

	before_update :kn_code_update
	after_create :assignments
	before_save :assignments_before_save

	def is_on_create
		@model_is_in_create = true
		return true
	end

	def is_on_update
		@model_is_in_update = true
		return true
	end

	scope :default_order, -> { 
		order(ident: :asc)
	}

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
		fillup_virtual :local_taric, fields: [:kncode, :description]
	end

	def unique_by_assocs
		if Good.exists?(ident: ident)
			@current = Good.where(ident: self.ident).first
			instructs = { impexpcompany: :company_name, manufacturer: :name }
			res = []

			instructs.each do |x, y|
				assocs = @current.send(x.to_s.pluralize)
				if assocs.exists?(y => instance_variable_get("@#{x.to_s}_#{y.to_s}"))
					res << true
				end 
			end

			if res.length == instructs.length
				errors.add(:ident, "existuje")
			else
				if ((!@impexpcompany.nil?)&&(!@manufacturer.nil?))
					assignments 
					return true
				end
			end
		else
			@current = self
			return true
		end
	end

	def associated_validations
		assoc_validator LocalTaric, :kncode, :description
		assoc_validator Impexpcompany, :company_name
		assoc_validator Manufacturer, :name
		assoc_validator_uoms @uoms
	end

	def must_have_one_or_more_impexpcompanies
		if self.impexpcompany_ids.blank?
			self.errors.add(:impexpcompany_ids, "nic")
		end
	end

	def assignments_before_save
		@current.local_taric_id = @local_taric.id if @model_is_in_create
	end

	def assignments
		@impexpcompany.goods << @current
		@manufacturer.goods << @current

		# this search should always return unique one result 
		#gm = @manufacturer.goods_manufacturers.where(
		#	good_id: @current.id
		#).first.uoms

		#@uoms.each do |uom|
		#	gm << Uom.new(uom)
		#end

		@uoms.each do |uom|	
			tmp = Uom.new(uom)
			tmp.manufacturer_id = @manufacturer.id
			tmp.impexpcompany_id = @impexpcompany.id
			tmp.good_id = @current.id
			tmp.save
			#log @current.id
			#tmp.good << @current
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