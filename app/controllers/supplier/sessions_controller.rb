class Supplier::SessionsController < Devise::SessionsController
  #include Accessible
  #skip_before_action :check_user, only: :destroy

  protected

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || supplier_dashboard_path
  end
end
