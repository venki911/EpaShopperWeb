class ProductEditsService < BaseService

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


























=begin

  def self.sync_product_edit(product_edit)


    uri = URI("#{BASE_URL}/admin/orders.json")
    req = Net::HTTP::Get.new(uri)
    req.basic_auth PUBLIC_API_KEY, PUBLIC_API_PW

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req)
    }
    #puts res.body

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

=end


=begin
      uri = URI('http://epa-test2.myshopify.com/search?view=json&q=*')
      response = Net::HTTP.get_response(uri)
      jsonResponse = JSON.parse(response.body.force_encoding("UTF-8"), symbolize_names: true)
      p jsonResponse
      puts "=========================================================="
      p jsonResponse[:products]
=end
=begin
    uri = URI('https://epa-test2.myshopify.com/admin/orders.json')

    req = Net::HTTP::Get.new(uri)
    req.basic_auth '2e30548629436da9bb5daff1b2a001b5', '3dc0a4fc2c2464041b7c57d2ef5f1c5c'

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req)
    }
    puts res.body
    puts res.code
    puts 'done'

    case res
      when Net::HTTPSuccess then
        puts 'success'
      else
        puts 'failure'
    end
=end