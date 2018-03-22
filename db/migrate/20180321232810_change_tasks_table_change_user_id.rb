class ChangeTasksTableChangeUserId < ActiveRecord::Migration
  def change
    rename_column :tasks, :user_id_id, :user_id
  end
end
