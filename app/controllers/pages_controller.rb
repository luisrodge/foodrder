class PagesController < ApplicationController
  def home
    @restaurants = Restaurant.order("created_at DESC").limit(3)
  end
end
