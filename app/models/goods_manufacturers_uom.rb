class GoodsManufacturersUom < ActiveRecord::Base

	belongs_to :goods_manufacturer, inverse_of: :goods_manufacturers_uoms
	belongs_to :uom, inverse_of: :goods_manufacturers_uoms
	
end
