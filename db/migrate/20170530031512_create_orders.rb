class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :road
      t.integer :postcode
      t.string :town
      t.string :country
      t.binary :issued
      t.integer :total
      t.integer :stripe_id
      t.string :email

      t.timestamps
    end
  end
end
