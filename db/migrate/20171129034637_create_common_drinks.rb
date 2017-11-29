class CreateCommonDrinks < ActiveRecord::Migration[5.1]
  def change
    create_table :common_drinks do |t|
      t.references :drink, foreign_key: true
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
