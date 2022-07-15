class RemoveColumnFromTasks < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :tasks, :status, :integer }
  end
end
