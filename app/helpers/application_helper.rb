module ApplicationHelper

  def price_format(price)
    number_to_currency(price, :unit => "$")
  end
end
