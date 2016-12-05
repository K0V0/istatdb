class AddIndexesToImpexpcompanyManufacturers < ActiveRecord::Migration
  def change
  	 add_reference :impexpcompany_manufacturers, :impexpcompany, index: true, foreign_key: true
      add_reference :impexpcompany_manufacturers, :manufacturer, index: true, foreign_key: true
      add_reference :impexpcompany_manufacturers, :local_taric, index: true, foreign_key: true
      
  end
end
