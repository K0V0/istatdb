class AddIncotermToImpexpcompanyManufacturers < ActiveRecord::Migration
  def change
    add_reference :impexpcompany_manufacturers, :incoterm, index: true, foreign_key: true
  end
end
