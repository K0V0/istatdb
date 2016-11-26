class CreateGoodsManufacturersUoms < ActiveRecord::Migration
  def change
    create_table :goods_manufacturers_uoms do |t|
      t.references :goods_manufacturer
      t.references :uom_type

      t.timestamps null: false
    end
  end
end
