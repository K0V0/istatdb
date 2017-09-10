class RemoveIncotermFromImpexpcompanyManufacturers < ActiveRecord::Migration
  def change
    remove_column :impexpcompany_manufacturers, :incoterm, :integer
  end
end
