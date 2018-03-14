class AddIntrastatCodeToUomTypes < ActiveRecord::Migration
  def change
    add_column :uom_types, :intrastat_code, :text
  end
end
