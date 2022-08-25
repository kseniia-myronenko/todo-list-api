class RemoveIndexFromTasksName < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_index :tasks, column: [:name], name: 'index_tasks_on_name' }
  end
end
