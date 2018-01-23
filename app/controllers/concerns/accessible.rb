# This controller concern protects against cross model visits.
# Prevents admins from accessing authentication routes from
# supplier and vice-versa.
module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_admin
      flash.clear
      redirect_to(admin_dashboard_path) && return
    elsif current_supplier
      flash.clear
      redirect_to(supplier_dashboard_path) && return
    end
  end
end