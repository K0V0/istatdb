class FixUomColumnNames < ActiveRecord::Migration
  def change
  	rename_column :uoms, :uom_multipliter, :uom_multiplier
  end
end
