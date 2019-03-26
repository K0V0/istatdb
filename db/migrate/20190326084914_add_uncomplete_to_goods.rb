class AddUncompleteToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :uncomplete, :boolean
    add_column :goods, :uncomplete_reason, :text
  end
end
