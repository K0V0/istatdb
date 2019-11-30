class CreateImpexpcompanyIssues < ActiveRecord::Migration
  def change
    create_table :impexpcompany_issues do |t|
      t.references :impexpcompany, index: true, foreign_key: true
      t.references :issue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
