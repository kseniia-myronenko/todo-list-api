class CreateColumnInTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :deadline, :date
  end
end
