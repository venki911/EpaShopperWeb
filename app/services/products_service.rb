class ProductsService < BaseService

  def self.sync_product_edit(product_edit)


    uri = URI("#{BASE_URL}/admin/products/#{product_edit.product_id}.json")
    req = Net::HTTP::Put.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req.basic_auth PUBLIC_API_KEY, PUBLIC_API_PW
    req.body = product_edit.to_update_json

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req)
    }
    puts res.body

    edit_response = ProductEditResponse.new(status_code: res.code)

    case res
      when Net::HTTPSuccess then
        puts 'success'
      else
        puts 'failure'
        edit_response.operation_error = "Product update failed with status code #{res.code}"
    end

    return edit_response
  end

end
