class AddProcessingToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :processing, :boolean, :default => false
  end
end
