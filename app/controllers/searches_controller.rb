class SearchesController < ApplicationController

  def show
    search = params[:q].present? ? params[:q] : nil
    @foods = if params[:sort].present? && params[:sort] == "deliverable"
               Food.search(search, where: {
                   _or: [
                       {order_medium_type: 'pickup_and_delivery'},
                       {order_medium_type: 'only_delivery'}
                   ]
               })
             else
               Food.search(search)
             end

  end

end
