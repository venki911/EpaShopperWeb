require 'json'

class ProductEdit < ActiveRecord::Base

  COLOR_FULFILLED_CLASS = 'color-fulfilled'
  COLOR_SUBSTITUTED_CLASS = 'color-substituted'
  MARKUP_FACTOR = 1.15
  dragonfly_accessor :image

  # COMPUTED PROPERTIES
  #============================================================================================================
  def price_new_markup
    price != price_new ? (price_new * MARKUP_FACTOR).round(2) : price
  end

  def shopify_url
    "#{BaseService::BASE_URL}/admin/products/#{product_id}"
  end

  def edited_image_url
    # If no new image uploaded, just return original shopify image ulr (image_source)
    image.nil? ? image_source : image.url
  end

  def fields_to_edit?
    title != title_new || price != price_new || description.gsub('\n', ' ').rstrip != description_new.gsub('\n', ' ').rstrip || aisle != aisle_new
  end

  # METHODS
  #============================================================================================================
  def aisle_bg_class
    aisle != aisle_new ? updated_bg_class : ''
  end

  def price_bg_class
    price != price_new ? updated_bg_class : ''
  end

  def title_bg_class
    title != title_new ? updated_bg_class : ''
  end

  def description_bg_class
    description.gsub('\n', ' ').rstrip != description_new.gsub('\n', ' ').rstrip ? updated_bg_class : ''
  end

  def image_bg_class
    image.nil? ? '' : COLOR_SUBSTITUTED_CLASS
  end

  def updated_bg_class
    updated ? COLOR_FULFILLED_CLASS : COLOR_SUBSTITUTED_CLASS
  end


  # JSON HELPER METHODS
  #============================================================================================================
  def convert_from_json(json)
    self.variant_id = json[:variant_id]
    self.product_id = json[:product_id]
    self.image_source = json[:image_source]
    self.shopper_name = json[:shopper_name]

    self.title = json[:title]
    self.title_new = json[:title_new]
    self.description = json[:description]
    self.description_new = json[:description_new]
    self.price = json[:price]
    self.price_new = json[:price_new]
    self.aisle = json[:aisle]
    self.aisle_new = json[:aisle_new]

    self
  end


  def to_update_json

    product_json = {product: {id: self.product_id}}
    variant_json = {id: self.variant_id}


    if title != title_new
      product_json[:product][:title] = updated? ? title : title_new
    end
    if description.gsub('\n', ' ').rstrip != description_new.gsub('\n', ' ').rstrip
      product_json[:product][:body_html] = "<p>#{updated? ? description : description_new}<\/p>"
    end
    if price != price_new
      variant_json[:price] = updated? ? price : price_new_markup
    end
    if aisle != aisle_new
      variant_json[:sku] = updated? ? aisle : aisle_new
    end

    product_json[:product][:variants] = [variant_json]

    product_json.to_json
  end

end
