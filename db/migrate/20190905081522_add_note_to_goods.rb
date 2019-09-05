class AddNoteToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :note, :text
  end
end
