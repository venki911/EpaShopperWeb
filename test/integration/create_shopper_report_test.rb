require 'test_helper'

class CreateShopperReportTest < ActionDispatch::IntegrationTest

  def setup
    @json = {shopper_name: 'bob', orders_count: 22, shop_collections: [{aisle_count: 1, name: 'Costco', line_items: [{product_id: 4294967296, title: 'My Product'}]}]}
  end

  test 'create new shopper report' do

    assert_difference 'ShopperReport.count', 1 do
      post reports_path, shopper_report: @json
    end

    assert_match 'success', response.body

  end

end