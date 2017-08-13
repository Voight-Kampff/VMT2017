class AddConcertIdToInvitations < ActiveRecord::Migration[5.0]
  def change
  	add_column :invitations, :concert_id, :integer
  end
end
