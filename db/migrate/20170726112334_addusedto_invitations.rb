class AddusedtoInvitations < ActiveRecord::Migration[5.0]
  def change
  	add_column :invitations, :used, :boolean
  end
end
