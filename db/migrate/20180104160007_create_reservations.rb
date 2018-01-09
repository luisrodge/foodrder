class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :full_name
      t.string :phone_number
      t.integer :status, default: 0
      t.date :reserve_date
      t.time :reserve_time
      t.integer :persons
      t.references :restaurant, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
