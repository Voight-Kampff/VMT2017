class AddWideImageToConcerts < ActiveRecord::Migration[5.0]
  def change
    add_column :concerts, :wide_image, :string
  end
end
