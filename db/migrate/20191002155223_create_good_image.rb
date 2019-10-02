class CreateGoodImage < ActiveRecord::Migration
  def change
    create_table :good_images do |t|
      t.string :image
      t.references :good, index: true, foreign_key: true
    end
  end
end
