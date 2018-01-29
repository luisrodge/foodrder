class DropTableReadMarks < ActiveRecord::Migration[5.1]
  def change
    drop_table :read_marks
  end
end
