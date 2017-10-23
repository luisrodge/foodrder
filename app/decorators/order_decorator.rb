class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :order_items
  decorates_association :order_fragments


end
