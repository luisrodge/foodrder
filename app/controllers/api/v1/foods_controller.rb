class Api::V1::FoodsController < ApplicationController
  def show
    @food = Food.find(params[:id])
    render json: @food
  end
end
