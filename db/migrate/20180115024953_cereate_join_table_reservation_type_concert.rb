class CereateJoinTableReservationTypeConcert < ActiveRecord::Migration[5.0]
  def change
  	 create_table :concerts_reservation_types, id: false do |t|
     t.belongs_to :reservation_type, index: true
     t.belongs_to :concert, index: true
 	end
  end
end
