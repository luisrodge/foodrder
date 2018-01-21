class FoodsController < ApplicationController
  layout 'minimal', only: :show
  def index
    @foods = if params[:mc].present?
               Food.search(params[:mc])
             elsif params[:sort].present? && params[:sort] == "deliverable"
               Food.deliverable
             else
               Food.order("RANDOM()")
             end
  end

  def show
    @food = Food.find(params[:id])
  end
end
