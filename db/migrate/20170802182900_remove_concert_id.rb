class RemoveConcertId < ActiveRecord::Migration[5.0]
  def change
  	remove_column :locations, :concert_id, :integer
  end
end
