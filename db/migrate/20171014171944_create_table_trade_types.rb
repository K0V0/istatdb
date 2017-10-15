class CreateTableTradeTypes < ActiveRecord::Migration
  def change
    create_table :trade_types do |t|
      t.text :type
      t.text :description
    end
  end
end
