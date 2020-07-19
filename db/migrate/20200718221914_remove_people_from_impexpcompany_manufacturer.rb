class RemovePeopleFromImpexpcompanyManufacturer < ActiveRecord::Migration
  def change
    remove_reference :impexpcompany_manufacturers, :people, index: true, foreign_key: true
  end
end
