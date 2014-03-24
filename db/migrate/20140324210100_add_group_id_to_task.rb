class AddGroupIdToTask < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.references :group
    end
  end
end
