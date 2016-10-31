class GoodsImpexpcompanies < ActiveRecord::Migration
  def change
  	create_table :goods_impexpcompanies do |t|
      t.belongs_to :good, index: true
      t.belongs_to :impexpcompany, index: true
      t.timestamps null: false
  	end
  end
end
