class RemoveUomTypeIdIdFromUom < ActiveRecord::Migration
  def change
    remove_reference :uoms, :uom_type_id_id, index: true, foreign_key: true
  end
end
