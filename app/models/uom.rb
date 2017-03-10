class Uom < ActiveRecord::Base

	#belongs_to :goods_manufacturer, inverse_of: :uoms

	belongs_to :uom_type, inverse_of: :uoms
	belongs_to :impexpcompany, inverse_of: :uoms
	belongs_to :good, inverse_of: :uoms
	belongs_to :manufacturer, inverse_of: :uoms

	validates :uom, numericality: true, allow_blank: true

	validates :uom_multiplier, allow_blank: true, numericality: { only_integer: true, greater_than: 0 }

	validates_presence_of :uom_type_id, if: :uom?

	before_save :set_fallback_multiplier

	def set_fallback_multiplier
		if !self.uom.blank? && self.uom_multiplier.blank?
			self.uom_multiplier = 1
		end
	end

	def type
		uom_type.try(:uom_type)
	end

end
