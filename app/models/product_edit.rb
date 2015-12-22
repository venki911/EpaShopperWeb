class ProductEdit < ActiveRecord::Base

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
    self.price = json[:price_new]
    self.aisle = json[:aisle]
    self.aisle_new = json[:aisle_new]

    self
  end

end