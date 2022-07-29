class AddDefaultToDoneColumn < ActiveRecord::Migration[7.0]
  change_column_default(
    :tasks,
    :done,
    false
  )
end
