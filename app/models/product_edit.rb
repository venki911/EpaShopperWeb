require 'json'

class ProductEdit < ActiveRecord::Base

  COLOR_FULFILLED_CLASS = 'color-fulfilled'
  COLOR_SUBSTITUTED_CLASS = 'color-substituted'
  MARKUP_FACTOR = 1.15
  dragonfly_accessor :image

  # COMPUTED PROPERTIES
  #============================================================================================================
  def price_new_markup
    price_new * MARKUP_FACTOR
  end

  def shopify_url
    "#{BaseService::BASE_URL}/admin/products/#{product_id}"
  end

  def edited_image_url
    # If no new image uploaded, just return original shopify image ulr (image_source)
    image.nil? ? image_source : image.url
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
    image.nil? ? COLOR_SUBSTITUTED_CLASS : ''
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


  def get_update_json

    if updated?
      {
          # If already updated, return json to revert to original product information
          product:{
              id: self.product_id,
              title: self.title,
              body_html: "<p>#{self.description}<\/p>",
              variants: [{
                  id: self.variant_id,
                  price: self.price,
                  sku: self.aisle
                         }]
          }

      }.to_json
    else
      {
          # If not already updated, return json to convert to new values
          product:{
              id: self.product_id,
              title: self.title_new,
              body_html: "<p>#{self.description_new}<\/p>",
              variants: [{
                             id: self.variant_id,
                             price: self.price_new_markup,
                             sku: self.aisle_new
                         }]
          }

      }.to_json
    end
  end


end
