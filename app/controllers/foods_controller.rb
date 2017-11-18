class FoodsController < ApplicationController
  def index

    @foods = params[:mc].present? ? Food.search(params[:mc]) : Food.order("created_at DESC")
  end
end
