class Good < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults
	include NestedAttributesGetterConcern
	include NestedSelectedOrCreatedAnyConcern

	# nested_attributes - co je v textovych poliach
	# ids - checkboxy/ radiobuttony
	has_many :intertables, inverse_of: :good, dependent: :destroy
	accepts_nested_attributes_for(
		:intertables,
		reject_if: lambda { |c|
			c[:manufacturer_id].blank?&&c[:impexpcompany_id].blank?
		}
	)

	has_many :manufacturers, -> { distinct }, through: :intertables
	accepts_nested_attributes_for(
		:manufacturers,
		reject_if: lambda { |c|
			c[:allow_search_as_new] == "0"
		}
	)

	has_many :impexpcompanies, -> { distinct }, through: :intertables
	accepts_nested_attributes_for(
		:impexpcompanies,
		reject_if: lambda { |c|
			c[:allow_search_as_new] == "0"
		}
	)

	belongs_to :local_taric, inverse_of: :goods
	accepts_nested_attributes_for(
		:local_taric,
		reject_if: lambda { |c|
			c[:allow_search_as_new] == "0" || c[:allow_search_as_new].blank?
		}
	)

	has_many :uoms, inverse_of: :good
	accepts_nested_attributes_for(
		:uoms,
		reject_if: lambda { |c| c[:uom].blank? }
	)
	## resolve how to remove not wanted uoms
	# probably hidden field special delete helper

	nested_attrs_getter_for :manufacturers, :impexpcompanies, :local_taric
	## monkey patch for having <associated>_attributes getter and instance variable
	## from model itself when using accept_nested_attributes_for

	validates :ident, presence: true
	#validates :ident, uniqueness: true
	validate :at_least_one_impexpcompany_selected
	validate :at_least_one_manufacturer_selected
	validate :local_taric_selected_or_created

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

	def local_taric_selected_or_created
		if !nested_selected_or_created_any?(:local_taric, :kncode)
			self.errors.add(:local_taric_attributes, :not_selected_or_created)
		end
	end

	def at_least_one_impexpcompany_selected
		if !nested_selected_or_created_any?(:impexpcompanies, :company_name)
			self.errors.add(:impexpcompanies_attributes, :not_selected_or_created)
		end
	end

	def at_least_one_manufacturer_selected
		if !nested_selected_or_created_any?(:manufacturers, :name)
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
