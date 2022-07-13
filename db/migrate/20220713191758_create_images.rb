class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images, id: :uuid do |t|
      t.string :link
      t.references :comment, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
