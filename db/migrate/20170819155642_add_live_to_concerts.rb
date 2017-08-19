class AddLiveToConcerts < ActiveRecord::Migration[5.0]
  def change
  	add_column :concerts, :live, :boolean, :default => false
  end
end
