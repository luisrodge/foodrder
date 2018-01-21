class AddRestaurantToChoices < ActiveRecord::Migration[5.1]
  def change
    add_reference :choices, :restaurant, foreign_key: true
  end
end
