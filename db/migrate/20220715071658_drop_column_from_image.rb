class DropColumnFromImage < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :images, :link, :string }
  end
end
