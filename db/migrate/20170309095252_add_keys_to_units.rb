class AddKeysToUnits < ActiveRecord::Migration
  def change
  	add_reference :units, :good, index: true, foreign_key: true
    add_reference :units, :manufacturer, index: true, foreign_key: true
    add_reference :units, :impexpcompany, index: true, foreign_key: true
  end
end
