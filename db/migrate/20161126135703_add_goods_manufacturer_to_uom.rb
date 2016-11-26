class AddGoodsManufacturerToUom < ActiveRecord::Migration
  def change
    add_reference :uoms, :goods_manufacturer, index: true, foreign_key: true
  end
end
