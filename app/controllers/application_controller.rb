class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart

  private

  def set_cart
    @cart = Cart.find(cookies.encrypted[:cart])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    cookies.encrypted[:cart] = { value: @cart.id, expires: 3.days.from_now }
  end
end
