class AddTranslationsToTradeTypes < ActiveRecord::Migration
  def self.up
    TradeType.create_translation_table!({
      :description => :text
    }, {
      :migrate_data => true,
      :remove_source_columns => true
    })
  end

  def self.down
    TradeType.drop_translation_table! :migrate_data => true
  end
end
