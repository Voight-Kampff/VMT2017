class AddImageToConcerts < ActiveRecord::Migration[5.0]
  def change
    add_column :concerts, :image, :string
  end
end
