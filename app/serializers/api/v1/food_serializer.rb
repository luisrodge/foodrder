class Api::V1::FoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :primary_image
  belongs_to :restaurant

  class RestaurantSerializer < ActiveModel::Serializer
    attributes :name, :drinks, :order_medium_type
  end
end
