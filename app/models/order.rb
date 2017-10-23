class Order < ApplicationRecord
  has_many :order_fragments, dependent: :destroy
  has_many :order_items, dependent: :destroy

  before_create :set_confirmation_code

  # money-rails currency integration
  monetize :total_cents

  validates_presence_of :full_name, :phone_number, :location, :street

  # Order statuses
  enum status: [:pending, :order_confirmed, :restaurant_informed]

  # Return all pending orders
  def self.pending_orders
    where(status: 0).order("created_at DESC")
  end


  protected

  # Generate order confirmation code
  def generate_confirmation_code
    rand(0000..9999).to_s.rjust(4, "0")
  end

  def set_confirmation_code
    self.confirmation_code = generate_confirmation_code
  end
end
