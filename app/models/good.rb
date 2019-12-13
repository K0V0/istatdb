class Good < ActiveRecord::Base

	include Defaults
	include NestedAttributesGetterConcern
	include NestedSelectedOrCreatedAnyConcern

	extend OrderAsSpecified

	# nested_attributes - co je v textovych poliach
	# ids - checkboxy/radiobuttony

	attr_accessor :old_manufacturers_ids
	attr_accessor :old_impexpcompanies_ids
	attr_accessor :old_issues_ids

	belongs_to :user, inverse_of: :goods

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

	has_many :good_issues, inverse_of: :good#, dependent: :destroy
	accepts_nested_attributes_for(
		:good_issues,
		reject_if: lambda { |c|
			c[:good_id].blank?&&c[:íssue_id].blank?
		}
	)

	has_many :issues, -> { distinct }, through: :good_issues
	accepts_nested_attributes_for(
		:issues,
		reject_if: lambda { |c|
			c[:allow_search_as_new] == "0" || c[:allow_search_as_new].blank?
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
		reject_if: lambda { |c| c[:uom].blank? },
		allow_destroy: true
	)

	has_many :good_images, inverse_of: :good, dependent: :destroy
    accepts_nested_attributes_for(
        :good_images,
        allow_destroy: true,
        reject_if: proc { |c| c[:image].blank? and c[:image_cache].blank? }
    )

	nested_attrs_getter_for :manufacturers, :impexpcompanies, :local_taric, :issues
	## monkey patch for having <associated>_attributes getter and instance variable
	## from model itself when using accept_nested_attributes_for

	validates :ident, presence: true
	validates_uniqueness_of :ident, scope: :description
	validate :at_least_one_impexpcompany_selected
	validate :at_least_one_manufacturer_selected
	validate :local_taric_selected_or_created
	validates_associated :uoms
	# needed only when updating, as per documentation

	before_create :assign_to_user
	before_update :assign_to_moderator

	after_save :add_manufacturer_impexpcompany_relationships #aj update aj create ide
	after_save :add_good_impexpcompany_issue_relationships #aj update aj create ide

	after_update :update_manufacturer_impexpcompany_relationships
	after_update :update_good_issue_impexpcompany_relationships

	after_destroy :update_manufacturer_impexpcompany_relationships
	after_destroy :update_good_issue_impexpcompany_relationships

	#ransacker :created_at do
  		#Arel.sql('ident LIKE ?', '')
	#end

	scope :default_order, -> {
		order(ident: :asc)
	}

	#scope :ident_or_description_cont, -> (pars) {
		#logger pars
	#}

	##scope :ident_cont_intel, -> (pars) {
		##logger(pars)
		##self
		##.where("ident LIKE ?", "#{pars}")
	##}
	#
	#ransacker :by_country_state, formatter: proc { |v|
	   # City.where(country_state: v).map{ |city| city.ddd }.uniq
	   # }, splat_param: true do |parent|
	    #parent.table[:ddd]
	# end

	scope :impexpcompany_filter, -> (pars) {
		self
		.joins(:impexpcompanies)
		.where(impexpcompanies: {
			id: pars
		})
		.preload(:impexpcompanies)
		.distinct
	}

	scope :manufacturer_filter, -> (*pars) {
		self
		.joins(:manufacturers)
		.where(manufacturers: {
			id: pars
		})
		.preload(:manufacturers)
		.distinct
	}

	scope :uncomplete_filter, -> (pars) {
		if pars == "0"
			self.where(uncomplete: nil)
		elsif pars == "1"
			self.where(uncomplete: true)
		end
	}

	scope :issue_filter, -> (*pars) {
		self
		.joins(:issues)
		.where(issues: {
			id: pars
		})
		.preload(:issues)
		.distinct
	}

	def self.ransackable_scopes(*pars)
	    %i(impexpcompany_filter manufacturer_filter uncomplete_filter time_filter issue_filter, ident_or_description_cont)
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

	def add_manufacturer_impexpcompany_relationships
		self_manuf_ids = self.manufacturers.ids
		self_impexp_ids = self.impexpcompanies.ids
		# pridanie ak je novy vztah SJ <=> Vyrobca/odberatel
		self_impexp_ids.each do |self_impexp_id|
			self_manuf_ids.each do |self_manuf_id|
				ImpexpcompanyManufacturer.find_or_create_by(
					impexpcompany_id: self_impexp_id,
					manufacturer_id: self_manuf_id
				)
			end
		end
	end

	def decice_impexpcompany_manufacturer_relation_removal(impexp, manuf)
		g = Good
			.joins(:impexpcompanies, :manufacturers)
			.where(impexpcompanies: { id: impexp })
			.where(manufacturers: { id: manuf })
		if g.size == 0
			im = ImpexpcompanyManufacturer
				.where(impexpcompany_id: impexp)
				.where(manufacturer_id: manuf)
				.where(added_or_modded_by_user: false || nil)
			im.all.each do |im2remove|
				im2remove.destroy
			end
		end
	end

	def update_manufacturer_impexpcompany_relationships
		if @old_manufacturers_ids.nil?
			# deje sa pri odstranovani polozky
			removed_manufacturers = self.manufacturers.ids
		else
			removed_manufacturers = @old_manufacturers_ids - self.manufacturers.ids
		end

		if @old_impexpcompanies_ids.nil?
			# detto
			removed_impexpcompanies = self.impexpcompanies.ids
		else
			removed_impexpcompanies = @old_impexpcompanies_ids - self.impexpcompanies.ids
		end

		if !removed_manufacturers.blank?
			Impexpcompany.all.each do |ri|
				removed_manufacturers.each do |rm|
					decice_impexpcompany_manufacturer_relation_removal(ri, rm)
				end
			end
		end

		if !removed_impexpcompanies.blank?
			Manufacturer.all.each do |rm|
				removed_impexpcompanies.each do |ri|
					decice_impexpcompany_manufacturer_relation_removal(ri, rm)
				end
			end
		end
	end

	def add_good_impexpcompany_issue_relationships
		self_id = self.id
		self_issue_ids = self.issues.ids
		self_impexp_ids = self.impexpcompanies.ids
		self_impexp_ids.each do |self_impexp_id|
			self_issue_ids.each do |self_issue_id|
				GoodIssue.find_or_create_by(
					good_id: self_id,
					impexpcompany_id: self_impexp_id,
					issue_id: self_issue_id
				)
			end
		end
	end

	def update_good_issue_impexpcompany_relationships
		if @old_issues_ids.nil?
			# deje sa pri odstranovani polozky
			removed_issues = self.issues.ids
		else
			removed_issues = @old_issues_ids - self.issues.ids
		end
		if @old_impexpcompanies_ids.nil?
			# detto
			removed_impexpcompanies = self.impexpcompanies.ids
		else
			removed_impexpcompanies = @old_impexpcompanies_ids - self.impexpcompanies.ids
		end
		if !removed_impexpcompanies.blank?
			gi = GoodIssue
					.where(good_id: self.id)
					.where(impexpcompany_id: removed_impexpcompanies)
			gi.delete_all
		end
		if !removed_issues.blank?
			gi = GoodIssue
					.where(good_id: self.id)
					.where(issue_id: removed_issues)
			gi.delete_all
		end
	end

	def assign_to_user
		self.user = User.current
	end

	def assign_to_moderator
		self.updated_by = User.current.id
	end

	def name_field
		self.ident
	end

	def user_added
		self.user.email
	end

	def user_modded
		if !self.updated_by.blank?
			User.find(self.updated_by).email
		end
	end

	def patale
		self.issues.map{ |i| "#{i.season.strftime('%m/%Y')} - #{i.name}" }.join('<br>').html_safe
	end

	def reason_and_note
		if !self.uncomplete_reason.blank?&&!self.note.blank?
			"<b>Došetrovanie:</b> \r\n #{self.uncomplete_reason} \r\n<hr><b>Poznámky:</b> \r\n #{self.note}"
		else
			"#{self.uncomplete_reason}\r\n#{self.note}"
		end
	end

end
