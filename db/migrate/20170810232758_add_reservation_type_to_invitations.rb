class AddReservationTypeToInvitations < ActiveRecord::Migration[5.0]
  def change
  	add_column :invitations, :reservation_type_id, :integer
  end
end
