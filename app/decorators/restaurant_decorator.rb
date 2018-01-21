class RestaurantDecorator < Draper::Decorator
  delegate_all

  def address
    object.street + ', ' + object.location
  end

  def menu_food_counter
    h.pluralize(object.menus.count, "Menu") + ', ' + h.pluralize(object.foods.count, "Food")
  end

end
