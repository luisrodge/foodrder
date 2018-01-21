class CreateChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :choices do |t|
      t.string :name
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end
