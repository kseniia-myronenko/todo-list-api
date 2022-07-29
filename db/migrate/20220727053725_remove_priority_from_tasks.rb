class RemovePriorityFromTasks < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :tasks, :priority, :integer }
  end
end
