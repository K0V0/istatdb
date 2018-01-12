class AddUserIdToSettings < ActiveRecord::Migration
  def change
    add_reference :settings, :user, index:true
  end
end
