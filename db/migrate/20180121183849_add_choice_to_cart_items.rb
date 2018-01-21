class AddChoiceToCartItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :cart_items, :choice, foreign_key: true
  end
end
