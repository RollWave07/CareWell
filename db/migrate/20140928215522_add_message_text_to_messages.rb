class AddMessageTextToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :message_text, :text
  end
end
