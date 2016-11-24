class AddUomToGoodsManufacturer < ActiveRecord::Migration
  def change
    add_column :goods_manufacturers, :uom, :float
  end
end
