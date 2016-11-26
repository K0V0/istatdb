class CreateUoms < ActiveRecord::Migration
  def change
    create_table :uoms do |t|
      t.float :uom
      t.integer :uom_multipliter
      t.references :uom_type_id

      t.timestamps null: false
    end
  end
end
