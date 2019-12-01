class AddImpexpcompanyToGoodIssues < ActiveRecord::Migration
  def change
    add_reference :good_issues, :impexpcompany, index: true, foreign_key: true
  end
end
