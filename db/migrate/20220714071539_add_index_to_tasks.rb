class AddIndexToTasks < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :tasks, :name, unique: true, algorithm: :concurrently
  end
end
