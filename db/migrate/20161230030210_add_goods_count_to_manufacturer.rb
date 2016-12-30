class AddGoodsCountToManufacturer < ActiveRecord::Migration
  def change
    add_column :manufacturers, :goods_count, :integer
  end
end
