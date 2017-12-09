class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart
  before_action :set_restaurant

  private

  def set_cart
    @cart = Cart.find(cookies.encrypted[:cart])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    cookies.encrypted[:cart] = { value: @cart.id, expires: 5.days.from_now }
  end

  def set_restaurant
    @current_restaurant = current_seller.restaurant if seller_signed_in?
  end
end
