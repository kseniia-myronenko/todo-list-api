class AddIndexToUsers < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :users, :username, unique: true, algorithm: :concurrently
  end
end
