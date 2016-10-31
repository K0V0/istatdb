class CreateLocalTarics < ActiveRecord::Migration
  def change
    create_table :local_tarics do |t|
      t.string :kncode
      t.string :description
      t.string :additional_info

      t.timestamps null: false
    end
  end
end
