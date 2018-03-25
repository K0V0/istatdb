class CreateTaskTypes < ActiveRecord::Migration
  def change
    create_table :task_types do |t|
        t.string :typ

    end
  end
end
