class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.text :content
      t.references :task, null: false, foreign_key: true, type: :uuid
      t.text :file_data

      t.timestamps
    end
  end
end
