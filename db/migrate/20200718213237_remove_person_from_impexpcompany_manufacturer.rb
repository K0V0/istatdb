class RemovePersonFromImpexpcompanyManufacturer < ActiveRecord::Migration
  def change
    remove_reference :impexpcompany_manufacturers, :person, index: true, foreign_key: true
  end
end
