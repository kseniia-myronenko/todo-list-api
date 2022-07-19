class AddAdditionalColumnsToTasks < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      change_table :tasks, bulk: true do |t|
        t.integer :priority
        t.boolean :done
      end
    end
  end
end
