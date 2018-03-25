class CreateTasksSecondTime < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
        t.text :task
        t.references :user, index: true, foreign_key: true
        t.boolean :done, default: false
        t.references :task_type, index: true, foreign_key: true
        t.timestamps
    end
  end
end
