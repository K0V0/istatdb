class GoodsManufacuters < ActiveRecord::Migration

  def change
  	create_table :goods_manufacturers do |t|
      t.belongs_to :good, index: true
      t.belongs_to :manufacturer, index: true
      t.timestamps null: false
  	end
  end

end
