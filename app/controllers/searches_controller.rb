class SearchesController < ApplicationController

  def show
    search = params[:q].present? ? params[:q] : nil
    @foods = Food.search(search)
  end

end
