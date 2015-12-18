require 'test_helper'

class ShopperReportsTest < ActiveSupport::TestCase

  test 'parse json' do
    json = {shopper_name: 'bob', orders_count: 22, shop_collections: [{aisle_count: 1, name: 'Costco', line_items: [{product_id: 123121, title: 'My Product'}]}]}
    shopper_report = ShopperReport.new
    shopper_report.convert_from_json(json)

    assert shopper_report.shopper_name == 'bob' && shopper_report.shop_collections.first.name == 'Costco' && shopper_report.shop_collections.first.line_items.first.product_id == 123121

    assert shopper_report.save

  end

end