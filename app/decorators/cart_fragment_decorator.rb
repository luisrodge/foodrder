class CartFragmentDecorator < Draper::Decorator
  delegate_all
  decorates_association :cart_items


end
