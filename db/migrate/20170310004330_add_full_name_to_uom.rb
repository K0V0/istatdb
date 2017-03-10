class AddFullNameToUom < ActiveRecord::Migration
  def change
    add_column :uom_types, :full_name, :string
  end
end
