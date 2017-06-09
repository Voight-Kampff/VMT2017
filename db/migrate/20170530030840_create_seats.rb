class CreateSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :seats do |t|
      t.string :row
      t.integer :column
      t.integer :price
      t.integer :concert_id

      t.timestamps
    end
  end
end
