class RemoveIndexFromProjectName < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_index :projects, column: [:name], name: 'index_projects_on_name' }
  end
end
