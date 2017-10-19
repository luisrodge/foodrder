class SessionsController < Devise::SessionsController

  # Specify the user to sign in by using their type attribute
  def create
    rtn = super
    sign_in(resource.type.underscore, resource.type.constantize.send(:find, resource.id)) unless resource.type.nil?
    rtn
  end

end
