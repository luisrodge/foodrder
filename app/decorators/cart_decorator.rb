class CartDecorator < Draper::Decorator
  delegate_all

  def format_total
    h.number_to_currency(object.total, unit: "$")
  end

end
