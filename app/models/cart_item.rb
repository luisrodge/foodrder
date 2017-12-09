class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :cart_fragment
  belongs_to :variant, optional: true
  belongs_to :itemable, polymorphic: true

  has_many :item_additions, as: :item_additionable, validate: false, dependent: :destroy
  has_many :additions, through: :item_additions

  monetize :total_cents

  attr_accessor :delivery
  attr_accessor :drink


  validates :quantity, presence: true,
            numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 10}

  # Update a CartItem quantity then update Cart total
  def update_item(params)
    existing_cart = cart
    transaction do
      update_attributes!(params)
      update_attributes!(total: cart_item_total)
      existing_cart.update_total
    end
  rescue StandardError
    return false
  end

  # Remove a CartItem and associations then update Cart total
  def remove_item
    existing_cart = cart
    if cart_fragment.food_cart_items.count < 2
      if itemable_type == 'Drink'
        destroy
      else
        cart_fragment.destroy
      end
    else
      destroy
    end
    existing_cart.update_total
  end

  # Calculate single CartItem total correlated to
  # item price, quantity, existing variants, and additions.
  def cart_item_total
    if variant.present? && additions.any?
      (variant.price + additions_total) * quantity
    elsif variant.present?
      variant.price * quantity
    elsif additions.any?
      (additions_total + itemable.price) * quantity
    else
      itemable.price * quantity
    end
  end

  # Calculate additional totals if present
  def additions_total
    total = 0
    additions.each do |addition|
      total += addition.price
    end
    total
  end

  def variant_name_price
    "#{variant.name} - $#{variant.price}"
  end

  def additions_name
    additions.map{|a| a.name}.join(" ,")
  end

  def additions_name_price
    additions.map{|a| "#{a.name} - $#{a.price}"}.join(" ,")
  end
end
