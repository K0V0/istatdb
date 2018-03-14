class RemoveIntertablesIdAndUomIdFromIntertables < ActiveRecord::Migration
  def change
    remove_column :intertables, :intertables_id, :integer
    remove_column :intertables, :uom_id, :integer
  end
end
