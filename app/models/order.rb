class Order < ApplicationRecord
  belongs_to :restaurant, optional: true
  has_many :order_items, dependent: :destroy

  monetize :total_cents

  validates_presence_of :full_name, :phone_number, :location, :street
end
