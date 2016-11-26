class CreateUomTypes < ActiveRecord::Migration
  def change
    create_table :uom_types do |t|
      t.string :uom_type

      t.timestamps null: false
    end
  end
end
