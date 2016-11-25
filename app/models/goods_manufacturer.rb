class GoodsManufacturer < ActiveRecord::Base

	belongs_to :manufacturer, inverse_of: :goods_manufacturers
	belongs_to :good, inverse_of: :goods_manufacturers

	validates :uom, numericality: true, allow_blank: true

	validates :uom_multiplier, allow_blank: true, numericality: { only_integer: true, greater_than: 0 }

	before_save :set_fallback_multiplier

	def set_fallback_multiplier
		if !self.uom.blank? && self.uom_multiplier.blank?
			self.uom_multiplier = 1
		end
	end

end