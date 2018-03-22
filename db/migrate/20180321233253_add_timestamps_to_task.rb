class AddTimestampsToTask < ActiveRecord::Migration
  def change
    add_timestamps(:tasks)
  end
end
