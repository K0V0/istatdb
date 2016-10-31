class CreateImpexpcompanies < ActiveRecord::Migration
  def change
    create_table :impexpcompanies do |t|
	  t.text :company_name
	  t.text :affiliated_office
      t.timestamps null: false
    end
  end
end
