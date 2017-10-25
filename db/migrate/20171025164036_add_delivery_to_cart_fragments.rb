class AddDeliveryToCartFragments < ActiveRecord::Migration[5.1]
  def change
    add_column :cart_fragments, :delivery, :boolean, default: false
  end
end
