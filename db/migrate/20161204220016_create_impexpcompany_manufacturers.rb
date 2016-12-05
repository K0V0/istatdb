class CreateImpexpcompanyManufacturers < ActiveRecord::Migration
  def change
    create_table :impexpcompany_manufacturers do |t|

    t.timestamps null: false
    end
  end
end
