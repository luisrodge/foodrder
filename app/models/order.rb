class Order < ApplicationRecord
  has_many :order_fragments, dependent: :destroy
  has_many :order_items, dependent: :destroy

  after_commit :dispatch_restaurant_sms

  # money-rails currency integration
  monetize :total_cents

  validates_presence_of :phone_number

  # Order statuses
  enum status: [:pending, :processed]

  # Handles checking out of orders and association
  # of OrderFragment & OrderItem records.
  def self.checkout(order, cart)
    transaction do
      order.save
      cart.cart_fragments.each do |cart_fragment|
        # Create segregation of order items by restaurant using OrderFragment.
        # Associate OrderFragment with parent Order record.
        order_fragment = OrderFragment.create(order: order,
                                              restaurant: cart_fragment.restaurant,
                                              delivery: cart_fragment.delivery)

        # Assign each OrderItem to it's appropriate OrderFragment.
        cart_fragment.cart_items.each do |cart_item|
          order.order_items.create(food: cart_item.food,
                                   quantity: cart_item.quantity,
                                   order_fragment: order_fragment)
        end
        # Dispatch restaurant text message containing order details
        # if restaurant opted for text message notification of new orders.
        if order_fragment.restaurant.text_message?
          if order_fragment.delivery?
            order_fragment.update_attributes(status: 2)
          else
            order_fragment.update_attributes(status: 1)
          end
        end
      end
      # Checks if the order should immediately be marked
      # as processed on checkout, given certain conditions
      if order.processable_on_checkout?
        order.update_attributes(status: 1)
      end
    end
  end

  # Conditional check to see if the checked out order
  # satisfies all conditions such as to be marked as
  # processed immediately after checkout
  def processable_on_checkout?
    (all_deliveries? && all_sms_opted?) ||
        (order_fragments.count == 1 &&
            order_fragments.last.delivery? &&
            order_fragments.last.restaurant.text_message?)
  end

  # Invokes background job to dispatch sms messages
  def dispatch_restaurant_sms
    order_fragments.each do |order_fragment|
      DispatchRestaurantSmsJob.perform_later(order_fragment) if order_fragment.restaurant.text_message?
    end
  end

  def self.processed_orders
    where(status: 1).order("created_at DESC")
  end

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

  # Checks if all checkout orders are opted for delivery
  def all_deliveries?
    order_fragments.where(delivery: true).count == order_fragments.count
  end

  # Check if all restaurants associated with the checked out
  # OrderFragments have opted for order notices via sms message
  def all_sms_opted?
    order_fragments.joins(:restaurant)
        .where("restaurants.order_notify_type = ?", 1).count == order_fragments.count
  end

end
