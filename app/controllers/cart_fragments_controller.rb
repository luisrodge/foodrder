class CartFragmentsController < ApplicationController
  before_action :set_cart_fragment

  def update
    @cart_fragment.update_attributes(delivery: params[:delivery])
  end

  private

  def set_cart_fragment
    @cart_fragment ||= CartFragment.find(params[:id])
  end
end
