class RenameTablePeopleToReferents < ActiveRecord::Migration
  def change
  	rename_table :people, :referents
  end
end
