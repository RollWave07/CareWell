class AddPreferencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact_preference, :string
  end
end
