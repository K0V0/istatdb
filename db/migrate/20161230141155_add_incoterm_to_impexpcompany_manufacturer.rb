class AddIncotermToImpexpcompanyManufacturer < ActiveRecord::Migration
  def change
    add_column :impexpcompany_manufacturers, :incoterm, :integer
  end
end
