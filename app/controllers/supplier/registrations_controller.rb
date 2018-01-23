class Supplier::RegistrationsController < Devise::RegistrationsController
  include Accessible

  protected

  def sign_up_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

end
