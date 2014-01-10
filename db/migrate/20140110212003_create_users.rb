class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :picture
      t.string :role
      t.boolean :admin
      t.text :notes
      t.references :group, index: true

      t.timestamps
    end
  end
end
