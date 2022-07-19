class RemoveColumnFromUsers < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :users, :hashed_password, :string }
  end
end
