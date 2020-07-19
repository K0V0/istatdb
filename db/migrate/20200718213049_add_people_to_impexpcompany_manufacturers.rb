class AddPeopleToImpexpcompanyManufacturers < ActiveRecord::Migration
  def change
    add_reference :impexpcompany_manufacturers, :people, index: true, foreign_key: true
  end
end
