class AddChoiceToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :choice, foreign_key: true
  end
end
