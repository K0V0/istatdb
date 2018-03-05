class AddTranslationsToUomTypes < ActiveRecord::Migration
  def self.up
    UomType.create_translation_table!({
      :full_name => :text,
      :description => :text
    }, {
      :migrate_data => true,
      :remove_source_columns => true
    })
  end

  def self.down
    UomType.drop_translation_table! :migrate_data => true
  end
end
