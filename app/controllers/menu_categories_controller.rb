class MenuCategoriesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json {render json: MenuCategory.search(params[:q])}
    end
  end
end
