class CartItemDecorator < Draper::Decorator
  delegate_all

  def cart_item_image
    h.image_tag(object.food.primary_image.medium, class: "img-responsive") if food.primary_image?
  end

  def food_name
    object.food.name
  end

  def food_price
    h.number_to_currency(object.food.price, unit: "$")
  end

  def restaurant_name
    object.food.restaurant.name
  end
end
