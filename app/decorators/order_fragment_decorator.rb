class OrderFragmentDecorator < Draper::Decorator
  delegate_all

  def update_status_btn
    btn_text = ''
    modal_txt = ''
    if object.pending?
      btn_text = 'Restaurant Informed'
      modal_txt = "Are you sure you have called #{object.restaurant.name}
                  and fully informed them about the order details?"
    elsif object.pending_pickup_ready?
      btn_text = 'Dispatch Pickup Ready Message'
      modal_txt = "Do not proceed unless you have verified from #{object.restaurant.name} that the order is ready."
    end

    h.link_to h.admin_order_fragment_path(order_fragment),
              method: :put,
              data: {
                  confirm: 'Are you sure?',
                  'confirm-button-text': 'Yes',
                  'cancel-button-color': '#d9534f',
                  text: "#{modal_txt}",
              },
              class: "btn btn-primary btn-lg btn-block" do
      if object.pending_pickup_ready?
        h.concat h.content_tag :i, nil, class: "fa fa-commenting-o"
      else
        h.concat h.content_tag :i, nil, class: "fa fa-phone"
      end
      h.concat ' '
      h.concat btn_text
    end
  end

  def status_instructions
    instructions_txt = ''
    if object.pending?
      instructions_txt = "Call #{object.restaurant.name} and inform them
                          about the new order and order details. Clearly state
                          out each order item and additional attributes. "
      if object.delivery?
        instructions_txt += "Remember to also state the delivery address."
      else
        instructions_txt += "Remember to also state the confirmation number
                            and ask for an estimate time to call back and verify
                            if the order is ready for pickup."
      end
    elsif object.pending_pickup_ready?
      instructions_txt = "Before dispatching the pickup message to the customer ensure that you have called back #{object.restaurant.name} to very that the order is fully ready."
    end
    instructions_txt
  end

end
