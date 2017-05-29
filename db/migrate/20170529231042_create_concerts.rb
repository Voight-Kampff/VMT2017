class CreateConcerts < ActiveRecord::Migration[5.0]
  def change
    create_table :concerts do |t|
      t.string :name
      t.string :shortname
      t.datetime :date
      t.binary :seating
      t.string :location

      t.timestamps
    end
  end
end
