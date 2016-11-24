class GoodsManufacturer < ActiveRecord::Base

	belongs_to :manufacturer, inverse_of: :goods_manufacturers
	belongs_to :good, inverse_of: :goods_manufacturers

	validates :uom, numericality: true, allow_blank: true

end