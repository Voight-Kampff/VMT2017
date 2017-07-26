class Change < ActiveRecord::Migration[5.0]
  def change
  	remove_column :orders, :stripe_id, :integer
  	add_column :orders, :stripe_token, :string
  end
end
