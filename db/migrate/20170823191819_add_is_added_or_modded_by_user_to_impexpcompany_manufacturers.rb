class AddIsAddedOrModdedByUserToImpexpcompanyManufacturers < ActiveRecord::Migration
  def change
    add_column :impexpcompany_manufacturers, :added_or_modded_by_user, :boolean
  end
end
