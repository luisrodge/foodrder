class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :order_items
  decorates_association :order_fragments

  def process_title
    title = ''
    if object.pending?
      title = "Pending Order Items (#{object.pending_order_fragments.count})"
    else
      title = 'Order Processed And Archived'
    end
    h.content_tag :h1, title, class: "text-title"
  end

  def update_status_btn
    btn_text = ''
    if object.pending?
      btn_text = 'Order Confirmed'
    elsif object.order_confirmed?
      btn_text = 'Restaurant Informed'
    end

    unless object.processed?
      h.button_to "#{btn_text}",
                  h.admin_order_path(order),
                  method: :put, disable_with: "Updating Status",
                  class: "btn btn-primary btn-lg"
    end

  end

end
