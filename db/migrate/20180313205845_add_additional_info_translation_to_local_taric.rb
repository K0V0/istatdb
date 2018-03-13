class AddAdditionalInfoTranslationToLocalTaric < ActiveRecord::Migration
    def self.up
        LocalTaric.add_translation_fields!(
            { additional_info: :text },
            {
                :migrate_data => true,
                :remove_source_columns => true
            }
        )
    end

    def self.down
        remove_column :local_taric_translations, :additional_info
    end
end
