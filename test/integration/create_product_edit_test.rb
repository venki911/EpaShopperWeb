require 'test_helper'

class CreateProductEditTest < ActionDispatch::IntegrationTest

  def setup
    @json = {shopper_name: 'bob', variant_id: 4294967296, product_id: 4294967296, image_source: '', title: 'Title', description: 'Description', aisle: 'aisle', title_new: 'Title', description_new: 'Description', aisle_new: 'aisle', price: 54.00, price_new: 54.00 }
  end

  test 'create new product edit' do

    assert_difference 'ProductEdit.count', 1 do
      post product_edits_path, product_edit: @json
    end

    assert_match 'success', response.body

    saved_product = ProductEdit.last
    assert saved_product.variant_id = @json[:variant_id]
    assert saved_product.title = @json[:title]

  end

end