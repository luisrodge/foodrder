class AddRestaurantToVariants < ActiveRecord::Migration[5.1]
  def change
    add_reference :variants, :restaurant, foreign_key: true
  end
end
