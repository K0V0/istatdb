class RemoveKncodeFromGoods < ActiveRecord::Migration
  def change
    remove_column :goods, :kncode, :text
  end
end
