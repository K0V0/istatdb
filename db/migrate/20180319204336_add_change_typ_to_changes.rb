class AddChangeTypToChanges < ActiveRecord::Migration
  def change
    add_column :changes, :change_typ, :integer
  end
end
