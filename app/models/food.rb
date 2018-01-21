class Food < ApplicationRecord
  include Taggable
  include Variantable

  belongs_to :restaurant
  belongs_to :menu

  has_many :choices
  accepts_nested_attributes_for :choices

  has_many :cart_items, as: :itemable
  has_many :order_items, as: :itemable

  validates_presence_of :name, :price_cents

  # Carrierwave uploader
  mount_uploader :primary_image, PrimaryImageUploader

  monetize :price_cents

  # For searchkick model searching
  searchkick

  # Search Food records by food name and Tags
  def search_data
    attributes.merge(
        name: name,
        tags_name: tags.map(&:name),
        order_medium_type: restaurant.order_medium_type
    )
  end

  # Return all restaurants that offer delivery
  def self.deliverable
    joins(:restaurant)
        .where('restaurants.order_medium_type = ? OR restaurants.order_medium_type=?', 1, 2)
        .order("created_at DESC")
  end

  def customizable?
    variants.any? || menu.additions.any? || choices.any?
  end

  def variats_name_price
    variants.map {|a| "#{a.name} - $#{a.price}"}.join(", ")
  end

  def choices_name
    choices.map {|a| "#{a.name}"}.join(", ")
  end
end
