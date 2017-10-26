class FoodsController < ApplicationController
  def index
    @foods = Food.order("created_at DESC")
  end
end
