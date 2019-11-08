class AddUpdatedByToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :updated_by, :integer
  end
end
