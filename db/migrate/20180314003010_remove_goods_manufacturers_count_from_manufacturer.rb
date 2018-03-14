class RemoveGoodsManufacturersCountFromManufacturer < ActiveRecord::Migration
  def change
    remove_column :manufacturers, :goods_manufacturers_count, :integer
  end
end
