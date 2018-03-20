class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :task
      t.references :user_id
      t.boolean :done, default: false
    end
  end
end
