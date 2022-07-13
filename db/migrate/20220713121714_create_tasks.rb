class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :name
      t.references :project, null: false, foreign_key: true, type: :uuid
      t.integer :status
      t.datetime :deadline

      t.timestamps
    end
  end
end
