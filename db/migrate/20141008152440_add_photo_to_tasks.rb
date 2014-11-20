class AddPhotoToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :photo, :string
  end
end
