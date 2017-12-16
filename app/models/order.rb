class Order < ApplicationRecord
  has_many :order_fragments, dependent: :destroy
  has_many :order_items, dependent: :destroy

  after_commit :start_jobs, on: :create

  # money-rails currency integration
  monetize :total_cents

  validates_presence_of :full_name, :phone_number
  validates :phone_number, numericality: {only_integer: true},
            length: {minimum: 7, maximum: 7}

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
          order.order_items.create(itemable: cart_item.itemable,
                                   total_cents: cart_item.total_cents,
                                   variant: cart_item.variant,
                                   quantity: cart_item.quantity,
                                   order_fragment: order_fragment,
                                   addition_ids: cart_item.addition_ids)
        end
        # Dispatch restaurant text message containing new order details
        if order_fragment.delivery?
          order_fragment.update_attributes(status: 1)
        end
      end
      # Checks if the order should immediately be marked
      # as processed on checkout, given certain conditions
      if order.all_deliveries?
        order.update_attributes(status: 1)
      end
    end
  end

  # Invokes background job to dispatch sms messages
  # and perform action cable broadcast new restaurant
  # orders to seller dashboard
  def start_jobs
    order_fragments.each do |order_fragment|
      DispatchRestaurantSmsJob.perform_later(order_fragment)
      OrderFragmentRelayJob.perform_later(order_fragment)
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

  def any_deliveries?
    order_fragments.where(delivery: true).any?
  end

end
