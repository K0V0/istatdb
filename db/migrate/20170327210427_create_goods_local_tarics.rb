class CreateGoodsLocalTarics < ActiveRecord::Migration
  def change
    create_table :goods_local_tarics do |t|

    	t.references :goods_local_tarics, :good, index: true, foreign_key: true
   		t.references :goods_local_tarics, :local_taric, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
