class Customer::RegistrationsController < Devise::RegistrationsController

  protected

  def sign_up_params
    params.require(:customer).permit(:email, :password, :password_confirmation)
  end

end
