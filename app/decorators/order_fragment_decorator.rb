class OrderFragmentDecorator < Draper::Decorator
  delegate_all

  def update_status_btn
    btn_text = ''
    if object.pending_confirmation?
      btn_text = '1. Confirmation Received From Customer'

    elsif object.restaurant_notified?
      btn_text = '2. Restaurant Notified'
    elsif object.pickup_ready?
      btn_text = '3. Informed Customer Pickup Ready'
    end

    h.button_to "#{btn_text}",
                h.admin_order_fragment_path(order_fragment),
                method: :put, disable_with: "Updating Status",
                class: "btn btn-primary btn-lg btn-block"
  end

end
