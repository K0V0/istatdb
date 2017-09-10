class DropImpexpcompanyManufacturersIncoterms < ActiveRecord::Migration
  def change
  	drop_table :impexpcompany_manufacturers_incoterms
  end
end
