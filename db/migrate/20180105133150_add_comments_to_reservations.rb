class AddCommentsToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :comments, :text
  end
end
