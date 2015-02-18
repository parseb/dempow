class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :city, :string
    add_column :users, :declaration, :string
  end
end
