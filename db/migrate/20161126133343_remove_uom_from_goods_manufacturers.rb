class RemoveUomFromGoodsManufacturers < ActiveRecord::Migration
  def change
    remove_column :goods_manufacturers, :uom, :float
  end
end
