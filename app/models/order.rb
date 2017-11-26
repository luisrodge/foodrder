class Order < ApplicationRecord
  has_many :order_fragments, dependent: :destroy
  has_many :order_items, dependent: :destroy

  # money-rails currency integration
  monetize :total_cents

  validates_presence_of :phone_number

  # Order statuses
  enum status: [:pending, :processed]

  # Return all pending orders
  def self.pending_orders
    where('status = ?', 0).order("created_at DESC")
  end

  # Associated OrderFragment records that have not been processed.
  # Order them by delivery = true
  def pending_order_fragments
    order_fragments.where.not(status: '2').order(delivery: :desc)
  end

  # Checks if an Order has any associated OrderFragment
  # records that have not been processed
  def pending_order_fragments?
    order_fragments.where('status = ? or status = ?', 0, 1).any?
  end

end
