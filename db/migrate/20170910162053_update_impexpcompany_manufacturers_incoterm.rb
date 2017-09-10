class UpdateImpexpcompanyManufacturersIncoterm < ActiveRecord::Migration
  def change
  	add_reference :impexpcompany_manufacturers_incoterms, :impexpcompany_manufacturer, index: {:name => "impexpcompany_manufacturer"}
    add_reference :impexpcompany_manufacturers_incoterms, :incoterm, index: {:name => "incoterm"}
  end
end
