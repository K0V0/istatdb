class AddNoteToGoodIssueFiles < ActiveRecord::Migration
  def change
    add_column :good_issue_files, :note, :text
  end
end
