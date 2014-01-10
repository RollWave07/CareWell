class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :category
      t.text :information
      t.datetime :start_time
      t.string :duration
      t.datetime :task_date
      t.string :status
      t.references :user, index: true
      t.references :assignee, index: true
      t.references :location, index: true

      t.timestamps
    end
  end
end
