class FoodsController < ApplicationController
  layout 'minimal', only: :show
  before_action :set_foods, only: :index

  def index
  end

  def show
    @food = Food.find(params[:id])
  end

  private

  def set_foods
    @foods = if params[:mc].present?
               Food.search(params[:mc], page: params[:page], per_page: 15)
             elsif params[:sort].present? && params[:sort] == "deliverable"
               Food.deliverable.page(params[:page]).per(15)
             else
               Food.order(created_at: :desc).page(params[:page]).per(15)
             end
  end
end
