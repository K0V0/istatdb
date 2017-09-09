class Good < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults
	include NestedAttributesGetterConcern

	has_many :intertables, inverse_of: :good, dependent: :destroy
	accepts_nested_attributes_for(
		:intertables,
		reject_if: lambda { |c| (c[:manufacturer_id].blank?&&c[:impexpcompany_id].blank?) } 
	)

	has_many :manufacturers, -> { distinct }, through: :intertables
	accepts_nested_attributes_for(
		:manufacturers,
		reject_if: lambda { |c| c[:name].blank? } 
	)

	has_many :impexpcompanies, -> { distinct }, through: :intertables
	accepts_nested_attributes_for(
		:impexpcompanies,
		reject_if: lambda { |c| c[:company_name].blank? } 
	) 

	belongs_to :local_taric, inverse_of: :goods
	accepts_nested_attributes_for(
		:local_taric, 
		reject_if: :local_taric_selected
	)

	has_many :uoms, inverse_of: :good
	accepts_nested_attributes_for(
		:uoms,
		reject_if: lambda { |c| c[:uom].blank? }
	)

	nested_attrs_getter_for :manufacturers, :impexpcompanies
	## monkey patch for having <associated>_attributes getter and instance variable
	## from model itself when using accept_nested_attributes_for

	validates :ident, presence: true
	#validates :ident, uniqueness: true
	validate :at_least_one_impexpcompany_selected
	validate :at_least_one_manufacturer_selected

	after_save :update_manufacturer_impexpcompany_relationships

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

	def local_taric_selected
		## if is kncode selected from list (radio buttons) ignores text fields
		## execution halted when returned true
		!self.local_taric_id.blank?
	end

	def at_least_one_impexpcompany_selected
		if nested_selected_or_created_any?(:impexpcompanies, :company_name)
		## returns true if nothong found
		## check if parent has at least one association (persisted or newly created)
			self.errors.add(:impexpcompanies_attributes, :not_selected_or_created)
		end
	end

	def at_least_one_manufacturer_selected
		if nested_selected_or_created_any?(:manufacturers, :name)
			self.errors.add(:manufacturers_attributes, :not_selected_or_created)
		end
	end

	def update_manufacturer_impexpcompany_relationships
		# cleanup ImpexpcompanyManufacturer model
		# gopnik patch because before_ and after_destroy not working on Intertable model
		# when using collections (rails mistake by design)
		# update relationship table between impexpcompanies and manufacturers
		# based on goods they are both conected with
		impexps = Impexpcompany.preload(:manufacturers, goods: [:manufacturers])
		impexps.each do |impexp|
			# from ImpexpcompanyManufacturer model
			x = impexp.manufacturers.collect { |w| w.id }
			# by going through goods and their impexpcompanies
			y = impexp.goods.collect { |w| w.manufacturers.collect { |q| q.id } }.flatten.uniq
			missing_new_manufacturers = y - x
			manufacturers_deselected = x - y
			# create association if not exist
			impexp.manufacturers << Manufacturer.find(missing_new_manufacturers)
			# remove association if Intrastat client no more have any bussines with supplier/consumer
			# but leave it intact if user decided or some other informations are associated here 
			# (edited or added from manufacturers section for example)
			obsolete_mans_ids = impexp.manufacturers
				.joins(:impexpcompany_manufacturers)
				.where(id: manufacturers_deselected)
				.where(impexpcompany_manufacturers: { added_or_modded_by_user: false || nil })
				.distinct
				.ids
			impexp.manufacturers.delete(*obsolete_mans_ids)
		end
	end

end