class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_title
      t.text :event_details
      t.datetime :event_date
      t.string :event_location
      t.references :group, index: true
      t.timestamps
    end
  end
end
