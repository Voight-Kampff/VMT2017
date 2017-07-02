class ChangeConcerts < ActiveRecord::Migration[5.0]
  def change
  	remove_column :concerts, :seating, :boolean
  	add_column :concerts, :unnumbered, :boolean
  end
end
