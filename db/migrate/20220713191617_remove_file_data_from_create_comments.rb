class RemoveFileDataFromCreateComments < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :comments, :file_data, :text }
  end
end
