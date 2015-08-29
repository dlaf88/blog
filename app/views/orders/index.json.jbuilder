json.array!(@orders) do |order|
  json.extract! order, :id, :shipping_name, :billing_name, :index, :show, :new
  json.url order_url(order, format: :json)
end
