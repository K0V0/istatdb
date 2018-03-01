class AddUserToGoods < ActiveRecord::Migration
  def change
    add_reference :goods, :user, index: true, foreign_key: true
  end
end
