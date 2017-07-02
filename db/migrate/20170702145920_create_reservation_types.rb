class CreateReservationTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :reservation_types do |t|
    	t.string :name
    	t.integer :discount
      t.timestamps
    end
  end
end
