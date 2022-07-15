class AddIndexToProjects < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :projects, :name, unique: true, algorithm: :concurrently
  end
end
