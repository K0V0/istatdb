class Uom < ActiveRecord::Base

	include Defaults

	belongs_to :uom_type, inverse_of: :uoms
	belongs_to :impexpcompany, inverse_of: :uoms
	belongs_to :good, inverse_of: :uoms
	belongs_to :manufacturer, inverse_of: :uoms

	validates :impexpcompany, presence: true
	validates :manufacturer, presence: true
	validates :uom, numericality: true, presence: true
	validates :uom_multiplier, numericality: { only_integer: true, greater_than: 0 }
	
	validates_presence_of :uom_type_id, if: :uom?

	before_save :set_fallback_multiplier

	after_initialize :set_default_pcs_to_one

	def uom=(val)
		super(val.gsub(',', '.'))
	end

	def set_fallback_multiplier
		if !self.uom.blank? && self.uom_multiplier.blank?
			self.uom_multiplier = 1
		end
	end

	def set_default_pcs_to_one
		self.uom_multiplier ||= 1
	end

	def type
		uom_type.try(:uom_type)
	end

	def type_fullname
		uom_type.try(:full_name)
	end

	def description
		uom_type.try(:description)
	end

	def istat_code 
		ic = uom_type.try(:intrastat_code)
		ic.blank? ? "---" : ic
	end

	def manufacturer_name
		self.manufacturer.name
	end

	def impexpcompany_name
		self.impexpcompany.company_name
	end

end
