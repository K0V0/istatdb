class AddSeasonToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :season, :date
  end
end
