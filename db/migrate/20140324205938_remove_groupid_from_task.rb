class RemoveGroupidFromTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :groupid, :integer
  end
end
