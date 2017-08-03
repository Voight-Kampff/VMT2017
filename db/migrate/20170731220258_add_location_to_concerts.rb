class AddLocationToConcerts < ActiveRecord::Migration[5.0]
  def change
  	remove_column :concerts, :location, :string
  	add_column :concerts, :location_id, :integer
  end
end
