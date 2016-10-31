class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.text :ident
      t.text :description
      t.text :kncode

      t.timestamps null: false
    end
  end
end
