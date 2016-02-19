class AddFirstNameLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, index: true
    add_column :users, :last_name, :string, index: true
    add_index :users, [:first_name, :last_name]
  end
end
