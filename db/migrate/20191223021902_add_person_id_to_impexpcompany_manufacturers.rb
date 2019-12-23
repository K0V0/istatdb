class AddPersonIdToImpexpcompanyManufacturers < ActiveRecord::Migration
  def change
    add_reference :impexpcompany_manufacturers, :person, index: true, foreign_key: true
  end
end
