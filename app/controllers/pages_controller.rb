class PagesController < ApplicationController
  def home
    @foods = Food.order(created_at: :desc).limit(6)
    @restaurants = Restaurant.order("created_at DESC").limit(3)
  end
end
