class AddUomMultiplierToGoodsManufacturer < ActiveRecord::Migration
  def change
    add_column :goods_manufacturers, :uom_multiplier, :integer
  end
end
