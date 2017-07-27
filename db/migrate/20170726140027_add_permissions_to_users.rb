class AddPermissionsToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :admin, :boolean
  	add_column :users, :cashier, :boolean
  	add_column :users, :viewer, :boolean
  	add_column :users, :checker, :boolean
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :telephone, :string
  end
end
