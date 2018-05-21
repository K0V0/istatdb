class CreateLocalSettings < ActiveRecord::Migration
  def change
  	if !table_exists?(:settings)
	    create_table :settings do |t|
	      t.string :k
	      t.text :v

	      t.timestamps null: false
	    end
	end
  end
end
