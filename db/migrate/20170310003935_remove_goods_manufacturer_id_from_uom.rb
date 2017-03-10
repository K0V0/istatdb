class RemoveGoodsManufacturerIdFromUom < ActiveRecord::Migration
  def change
  	remove_reference :uoms, :goods_manufacturer_id, index: true, foreign_key: true
  end
end
