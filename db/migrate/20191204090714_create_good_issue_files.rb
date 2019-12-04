class CreateGoodIssueFiles < ActiveRecord::Migration
  def change
    create_table :good_issue_files do |t|
      t.string :file
      t.references :issue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
