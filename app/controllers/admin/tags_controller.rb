class Admin::TagsController < Admin::BaseController
  def index
    respond_to do |format|
      format.html
      format.json {render json: Tag.search(params[:q])}
    end
  end
end
