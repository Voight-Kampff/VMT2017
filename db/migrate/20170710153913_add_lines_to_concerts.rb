class AddLinesToConcerts < ActiveRecord::Migration[5.0]
  def change
  	add_column :concerts, :subline, :string
  	add_column :concerts, :footnote, :string
  end
end
