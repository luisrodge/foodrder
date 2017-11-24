module ApplicationHelper

  # Format money saved with money-rails
  def price_format(price)
    "#{humanized_money_with_symbol(price)} #{price.currency.iso_code}"
  end

  def pluralize_normal(model_name, count)
    "#{model_name}".pluralize(count)
  end

  def format_date(date)
    date.strftime("%A, %B #{date.day.ordinalize}")
  end

  def format_datetime(datetime)
    datetime.strftime("%A, %B #{datetime.day.ordinalize} @ %I:%M %p")
  end
end
