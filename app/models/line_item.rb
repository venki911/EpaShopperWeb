class LineItem < ActiveRecord::Base

  belongs_to :shop_collection

  def convert_from_json(json)
    self.variant_id = json[:variant_id]
    self.product_id = json[:product_id]
    self.title = json[:title]
    self.description = json[:description]
    self.image_source = json[:image_source]
    self.price = json[:price]
    self.quantity_requested = json[:quantity_requested] || 0
    self.quantity_substituted = json[:quantity_substituted] || 0
    self.quantity_missing = json[:quantity_missing] || 0
    self.aisle = json[:aisle]
    self
  end

  def quantity_found
    quantity_requested - quantity_substituted - quantity_missing
  end


end