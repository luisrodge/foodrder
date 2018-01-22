class Seller::Settings::ProfilesController < Seller::BaseController
  def edit
    @seller = current_seller
  end

  def update
    @seller = current_seller
    if @seller.valid_password?(seller_params[:current_password])
      if seller_params[:password].empty?
        if @seller.update(seller_params.except(:current_password, :password))
          redirect_to seller_dashboard_path, notice: "Profile successfully updated"
        else
          render :edit
        end
      elsif @seller.update(seller_params.except(:current_password))
        redirect_to seller_dashboard_path, notice: "Profile successfully updated"
      else
        render :edit
      end
    else
      #@seller.assign_attributes(seller_params.except(:current_password))
      # Explicitly add invalid password validation error to supplier instance
      @seller.errors.add(:current_password)
      render :edit
    end
  end

  private

  def seller_params
    params.require(:seller).permit(:name, :email, :password, :current_password)
  end
end
