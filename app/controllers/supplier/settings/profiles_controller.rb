class Supplier::Settings::ProfilesController < Supplier::BaseController
  def edit
    @supplier = current_supplier
  end

  def update
    @supplier = current_supplier
    if @supplier.valid_password?(supplier_params[:current_password])
      if supplier_params[:password].empty?
        if @supplier.update(supplier_params.except(:current_password, :password))
          redirect_to supplier_dashboard_path, notice: "Your profile has been successfully updated"
        else
          render :edit
        end
      elsif @supplier.update(supplier_params.except(:current_password))
        bypass_sign_in(@supplier)
        redirect_to supplier_dashboard_path, notice: "Your profile has been successfully updated"
      else
        render :edit
      end
    else
      #@seller.assign_attributes(seller_params.except(:current_password))
      # Explicitly add invalid password validation error to supplier instance
      @supplier.errors.add(:current_password)
      render :edit
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit(:email, :password, :current_password)
  end
end
