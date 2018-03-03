class AddTradeTypeToImpexpcompanyManufacturer < ActiveRecord::Migration
  def change
    add_reference :impexpcompany_manufacturers, :trade_type, index: true, foreign_key: true
  end
end
