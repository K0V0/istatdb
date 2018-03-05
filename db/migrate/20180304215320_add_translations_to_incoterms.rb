class AddTranslationsToIncoterms < ActiveRecord::Migration
  def self.up
    Incoterm.create_translation_table!({
      :description => :text
    })
  end

  def self.down
    Incoterm.drop_translation_table!
  end
end
