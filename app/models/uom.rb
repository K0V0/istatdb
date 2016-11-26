class Uom < ActiveRecord::Base

	belongs_to :goods_manufacturer, inverse_of: :uoms

	has_one :uom_type

end
