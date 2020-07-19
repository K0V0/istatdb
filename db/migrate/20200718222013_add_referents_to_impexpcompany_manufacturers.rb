class AddReferentsToImpexpcompanyManufacturers < ActiveRecord::Migration
  def change
    add_reference :impexpcompany_manufacturers, :referent, index: true, foreign_key: true
  end
end
