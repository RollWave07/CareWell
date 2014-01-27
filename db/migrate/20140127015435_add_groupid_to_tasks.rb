class AddGroupidToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :groupid, :integer
  end
end
