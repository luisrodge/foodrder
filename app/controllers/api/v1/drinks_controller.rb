class Api::V1::DrinksController < ApplicationController
  def index
    @drinks = Drink.search(params[:mc])
    render json: @drinks
  end
end
