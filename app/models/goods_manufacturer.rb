
class GoodsManufacturer < ActiveRecord::Base

	belongs_to :manufacturer, inverse_of: :goods_manufacturers, counter_cache: true
	belongs_to :good, inverse_of: :goods_manufacturers

	#has_many :uoms, inverse_of: :goods_manufacturer

end