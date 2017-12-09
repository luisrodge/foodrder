class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.references :restaurant, foreign_key: true
      t.time :open
      t.time :close
      t.text :recurring

      t.timestamps
    end
  end
end
