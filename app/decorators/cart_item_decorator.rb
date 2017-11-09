class CartItemDecorator < Draper::Decorator
  delegate_all

  def cart_item_image
    h.image_tag(object.food.primary_image_url(:medium), class: "img-responsive")
  end

  def food_name
    object.food.name
  end

  def food_price
    object.food.price
  end

  def restaurant_name
    object.food.restaurant.name
  end
end
