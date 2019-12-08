class AddLinkToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :link, :string
  end
end
