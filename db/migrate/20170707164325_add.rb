class Add < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservations, :code, :string
  	add_column :reservations, :scanned, :boolean
  end
end
