class ChangeGoodsCounterColumnName < ActiveRecord::Migration
  def change
  	rename_column :manufacturers, :goods_count, :goods_manufacturers_count
  end
end
