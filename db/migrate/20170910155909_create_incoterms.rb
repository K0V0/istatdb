class CreateIncoterms < ActiveRecord::Migration
  def change
    create_table :incoterms do |t|
      t.text :shortland

      t.timestamps null: false
    end
  end
end
