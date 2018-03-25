class AddTaskTypeToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :task_type, index: true, foreign_key: true
  end
end
