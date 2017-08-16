class CreateSeatCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :seat_codes do |t|
      t.integer :seat_id
      t.string :row
      t.integer :column
      t.string :code
      t.string :concert_name
      t.string :concert_date
      t.timestamps
    end
  end
end
