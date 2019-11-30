class CreateGoodIssues < ActiveRecord::Migration
  def change
    create_table :good_issues do |t|
      t.references :good, index: true, foreign_key: true
      t.references :issue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
