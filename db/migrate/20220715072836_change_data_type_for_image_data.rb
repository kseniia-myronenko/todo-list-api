class ChangeDataTypeForImageData < ActiveRecord::Migration[7.0]
  change_column :images, :image_data, :text
end
