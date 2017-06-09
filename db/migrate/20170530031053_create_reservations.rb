class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.integer :order_id
      t.integer :price
      t.integer :seat_id
      t.string :type

      t.timestamps
    end
  end
end
