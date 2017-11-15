class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :k
      t.text :v

      t.timestamps null: false
    end
  end
end
