class LineItem < ActiveRecord::Base

  include ActiveModel::Serializers::JSON
  belongs_to :shop_collection

  def convert_from_json(json)
    self.variant_id = json[:variant_id]
    self.product_id = json[:product_id]
    self.title = json[:title]
    self.description = json[:description]
    self.image_source = json[:image_source]
    self.price = json[:price]
    self.quantity_requested = json[:quantity_requested]
    self.quantity_substituted = json[:quantity_substituted]
    self.quantity_missing = json[:quantity_missing]
    self.aisle = json[:aisle]
    self
  end


  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    instance_values
  end



end