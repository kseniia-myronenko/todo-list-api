class AddColumnToImage < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :image_data, :string
  end
end
