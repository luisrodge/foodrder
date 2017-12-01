class CartItemDecorator < Draper::Decorator
  delegate_all

  def cart_item_image
    if object.itemable_type == "Food"
      h.image_tag(object.itemable.primary_image_url(:medium), class: "img-responsive") if
          object.itemable.primary_image
    else
      h.image_tag(object.itemable.variantable.primary_image_url(:medium), class: "img-responsive") if
          object.itemable.variantable.primary_image
    end
  end

  def cart_item_name
    if object.itemable_type == "Food"
      object.itemable.name
    else
      "#{object.itemable.variantable.name} - #{object.itemable.name}"
    end

  end

  def cart_item_price
    object.itemable.price
  end

  def restaurant_name
    object.itemable.restaurant.name
  end
end
