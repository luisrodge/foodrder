class SubscribersController < ApplicationController
  def create
    subscriber = Subscriber.new(subscriber_params)
    if subscriber.valid?
      subscriber.save
      flash[:success] = "Thanks for subscribing to foodrder. Now you'll never miss out on any food deals."
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Subscription attempt failed."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:mobile_number)
  end
end
