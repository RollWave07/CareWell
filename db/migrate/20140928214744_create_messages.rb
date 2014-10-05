class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message_text
      t.references :group, index: true
      t.references :user, index: true
      t.string :photo
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
