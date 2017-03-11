class RemoveGoodsManufacturerIdFromUom < ActiveRecord::Migration
  def change
  	remove_reference :uoms, :goods_manufacturer_id, index: true, foreign_key: true
 	remove_column :uoms, :goods_manufacturer_id
  end
end
