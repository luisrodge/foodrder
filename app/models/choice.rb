class Choice < ApplicationRecord
  belongs_to :food
  belongs_to :restaurant

  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
end
