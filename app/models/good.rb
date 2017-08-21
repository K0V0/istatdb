class Good < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults
	include NestedAttributesGetterConcern

	has_many :intertables, inverse_of: :good
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
		mans = Manufacturer.preload(goods: [:impexpcompanies])

		self.manufacturers.each do |m|
			x = mans.find(m.id).goods.uniq.collect { |w| w.impexpcompany_ids }.flatten.uniq
			Rails.logger.info "--------------"
			Rails.logger.info x
		end

=begin
		Rails.logger.info "--------------"
		Rails.logger.info self.manufacturers

		self.manufacturers.each do |man|
			# manufacturer should exist, if main is saved asssociations also new should be
			self.impexpcompanies.each do |impexp|
				# if manufacturer is not associated with impexpcompany, do it
				if !man.impexpcompanies.exists?(impexp.id)
					man.impexpcompanies << impexp
				end
			end
			man.impexpcompanies.each do |impexp|
				if !self.impexpcompanies.exists?(impexp.id)
					Rails.logger.info "--------------"
					Rails.logger.info "impexpcompany does not exist here anymore"
					if impexp.goods.size == 0 || man.goods.size == 0
						man.impexpcompanies.delete(impexp)
					end
				end
			end
		end
=end
	end

end