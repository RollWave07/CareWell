class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.text :comment
      t.string :picture
      t.references :task, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
