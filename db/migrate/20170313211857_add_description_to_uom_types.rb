class AddDescriptionToUomTypes < ActiveRecord::Migration
  def change
    add_column :uom_types, :description, :string
  end
end
