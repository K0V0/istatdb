class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.references :impexpcompany, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
