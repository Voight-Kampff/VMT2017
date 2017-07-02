class AddPublicToReservationType < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservation_types, :public, :boolean
  end
end
