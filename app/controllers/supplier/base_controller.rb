# Base seller controller that groups common seller logic
class Supplier::BaseController < ApplicationController
  before_action :authenticate_supplier!
  layout 'dashboard'
end
