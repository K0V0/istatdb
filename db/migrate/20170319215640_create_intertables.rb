class CreateIntertables < ActiveRecord::Migration
  def change
    create_table :intertables do |t|
	  t.references :intertables, :good, index: true, foreign_key: true
	  t.references :intertables, :manufacturer, index: true, foreign_key: true
      t.references :intertables, :impexpcompany, index: true, foreign_key: true
      t.references :intertables, :uom, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
