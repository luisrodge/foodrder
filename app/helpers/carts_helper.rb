module CartsHelper

  # Form that adds a new food order to cart
  def add_to_cart(food)
    simple_form_for CartItem.new do |f|
      f.input :food_id, as: :hidden, input_html: { value: food.id }
      button_tag(type: 'submit', class: "btn btn-success btn-sm") do
        content_tag :span, nil, class: 'glyphicon glyphicon-shopping-cart'
      end
    end
  end

end
