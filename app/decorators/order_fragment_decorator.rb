class OrderFragmentDecorator < Draper::Decorator
  delegate_all

  def update_status_btn
    btn_text = ''
    if object.pending?
      btn_text = '1. Restaurant Informed'

    elsif object.pending_pickup_ready?
      btn_text = '2. Pickup Message Dispatched'
    end

    h.button_to "#{btn_text}",
                h.admin_order_fragment_path(order_fragment),
                method: :put, disable_with: "Updating Status",
                class: "btn btn-primary btn-lg btn-block"
  end

end
