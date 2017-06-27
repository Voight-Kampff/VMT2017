class AddPaymentTypeToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :payment_type, :string
  	add_column :orders, :paid, :boolean
  	add_column :orders, :held, :boolean
  	add_column :orders, :hold_type, :string
  	add_column :orders, :code, :string
  end
end
