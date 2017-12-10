class CreateTimeFrames < ActiveRecord::Migration[5.1]
  def change
    create_table :time_frames do |t|
      t.time :open
      t.time :close
      t.references :schedule, foreign_key: true

      t.timestamps
    end
  end
end
