class Order < ApplicationRecord
  belongs_to :restaurant, optional: true
  has_many :order_items, dependent: :destroy

  monetize :total_cents

  validates_presence_of :full_name, :phone_number, :location, :street

  # Order possible statuses
  enum status: [:Pending, :Confirmed, :Cancelled]

  # Return all pending orders
  def self.pending_orders
    where(status: 0).order("created_at DESC")
  end
end
