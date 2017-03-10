class AddSomethingToUoms < ActiveRecord::Migration
  def change
  	add_reference :uoms, :good, index: true, foreign_key: true
    add_reference :uoms, :manufacturer, index: true, foreign_key: true
    add_reference :uoms, :impexpcompany, index: true, foreign_key: true
  end
end
