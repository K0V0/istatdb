class CreateLocalTaricTranslations < ActiveRecord::Migration
  #def change
    def self.up
        LocalTaric.create_translation_table!({
          :description => :text
        }, {
          :migrate_data => true,
          :remove_source_columns => true
        })
    end

    def self.down
        LocalTaric.drop_translation_table! :migrate_data => true
    end
  #end
end
