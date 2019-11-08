class AddNoteToManufacturers < ActiveRecord::Migration
  def change
    add_column :manufacturers, :note, :text
  end
end
