class CreateGlobalTarics < ActiveRecord::Migration
  def change
    create_table :global_tarics do |t|

      t.string :kncode
      t.text :description
      t.text :description2
      
  

      t.timestamps null: false
    end
  end
end
