require 'json'

class OrdersService < BaseService

  def self.get_orders_for_date(target_date)

    order_status = 'unshipped'

    uri = URI("#{BASE_URL}/admin/orders.json")
    req = Net::HTTP::Get.new(uri.path)
    req.set_form_data({:fulfillment_status => order_status, :fields => 'id, name, note, fulfillment_status, note_attributes'})
    req.basic_auth PUBLIC_API_KEY, PUBLIC_API_PW

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req)
    }

    orders_response = OrdersResponse.new(status_code: res.code)

    case res
      when Net::HTTPSuccess then
        json = JSON.parse(res.body, {:symbolize_names => true})
        orders_response.orders = json[:orders].collect{|x| Order.new.convert_from_json(x)}
        orders_response.orders = orders_response.orders.select{|x| x.for_date?(target_date)}
      else
        orders_response.operation_error = "Could not fetch orders for date. Failed with #{res.code}"
    end

    return orders_response

  end

end