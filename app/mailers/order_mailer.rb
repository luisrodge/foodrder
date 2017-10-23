class OrderMailer < ApplicationMailer

  def send_new_order_email(user)
    @user = user
    mail(:to => @user.email,
         :subject => 'A new order has been placed.')
  end
end
