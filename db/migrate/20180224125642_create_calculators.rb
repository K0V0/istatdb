class CreateCalculators < ActiveRecord::Migration
  def change
    create_table :calculators do |t|
      t.text :data
      t.references :impexpcompany, index: true, foreign_key: true
      t.references :manufacturer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
