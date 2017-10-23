# Base admin controller that groups common admin logic
class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard'
end
