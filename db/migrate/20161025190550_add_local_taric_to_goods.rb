class AddLocalTaricToGoods < ActiveRecord::Migration
  def change
    add_reference :goods, :local_taric, index: true, foreign_key: true
  end
end
