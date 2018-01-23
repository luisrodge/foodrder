class CreateMessageNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :message_numbers do |t|
      t.string :number
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
