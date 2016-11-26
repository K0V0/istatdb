class RemoveUomMultiplierFromGoodsManufacturers < ActiveRecord::Migration
  def change
    remove_column :goods_manufacturers, :uom_multiplier, :integer
  end
end
