class RemoveDeadlineColumnFromTasks < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :tasks, :deadline, :datetime }
  end
end
