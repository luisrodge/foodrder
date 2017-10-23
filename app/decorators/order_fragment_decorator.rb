class OrderFragmentDecorator < Draper::Decorator
  delegate_all

  def update_status_btn
    if object.pending? || object.customer_confirmed?
      btn_text = ''
      if object.pending?
        btn_text = 'Customer Confirmed'

      elsif object.customer_confirmed?
        btn_text = 'Restaurant Confirmed'
      end
      h.button_to "#{btn_text}",
                  h.admin_order_fragment_path(order_fragment),
                  method: :put, disable_with: "Updating Status",
                  class: "btn btn-success btn-block"
    end
  end

end
