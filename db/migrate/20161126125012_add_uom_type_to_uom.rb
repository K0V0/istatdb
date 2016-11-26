class AddUomTypeToUom < ActiveRecord::Migration
  def change
    add_reference :uoms, :uom_type, index: true, foreign_key: true
  end
end
