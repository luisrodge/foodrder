class FoodsController < ApplicationController
  def index
    @foods = if params[:mc].present?
               Food.search(params[:mc])
             elsif params[:sort].present? && params[:sort] == "deliverable"
               Food.deliverable
             else
               Food.order("created_at DESC")
             end
  end
end
