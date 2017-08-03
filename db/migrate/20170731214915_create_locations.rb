class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
    	t.string :name
    	t.string :preposition
    	t.string :address
    	t.string :access
    	t.integer :concert_id
      t.timestamps
    end
  end
end
