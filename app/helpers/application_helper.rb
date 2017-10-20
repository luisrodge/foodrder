module ApplicationHelper

  def price_format(price)
    number_to_currency(price, :unit => "$")
  end

  def pluralize_normal(model_name, count)
    "#{model_name}".pluralize(count)
  end
end
