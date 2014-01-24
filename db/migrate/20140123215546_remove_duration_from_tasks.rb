class RemoveDurationFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :duration, :string
  end
end
