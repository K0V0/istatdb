class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.text :change
      t.text :version_num

      t.timestamps null: false
    end
  end
end
