module ApplicationHelper

  # Format money saved with money-rails
  def price_format(price)
    "#{humanized_money_with_symbol(price)} #{price.currency.iso_code}"
  end

  def pluralize_normal(model_name, count)
    "#{model_name}".pluralize(count)
  end
end
