class DropImpexpcompanyIssuesTable < ActiveRecord::Migration
  def up
    drop_table :impexpcompany_issues
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
