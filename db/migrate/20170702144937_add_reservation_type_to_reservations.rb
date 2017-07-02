class AddReservationTypeToReservations < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservations, :reservation_type_id, :integer
  end
end
