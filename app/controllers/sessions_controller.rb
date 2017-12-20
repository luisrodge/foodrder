class SessionsController < Devise::SessionsController

  # Specify the user to sign in by using their type attribute
  def create
    rtn = super
    sign_in(resource.type.underscore, resource.type.constantize.send(:find, resource.id)) unless resource.type.nil?
    rtn
  end

  protected

  def after_sign_in_path_for(resource)
    if current_user.type == "Admin"
      admin_dashboard_path
    elsif current_user.type == "Seller"
      seller_dashboard_path
    else
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end
  end

end
