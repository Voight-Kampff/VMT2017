class AddFirstNameToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :first_name, :string
  	add_column :orders, :last_name, :string
  	add_column :orders, :telephone, :string
  	add_column :orders, :title, :string
  	add_column :orders, :notes, :text
  	add_column :orders, :flagged, :boolean
  	remove_column :orders, :name
  end
end
