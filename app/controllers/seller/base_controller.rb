# Base seller controller that groups common seller logic
class Seller::BaseController < ApplicationController
  before_action :authenticate_seller!
  layout 'dashboard'
end
