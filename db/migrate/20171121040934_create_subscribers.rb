class CreateSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribers do |t|
      t.string :mobile_number

      t.timestamps
    end
    add_index :subscribers, :mobile_number, unique: true
  end
end
