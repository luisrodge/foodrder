class AddPrimaryImageToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :primary_image, :string
  end
end
