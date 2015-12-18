class ShopperReport < ActiveRecord::Base

  include ActiveModel::Serializers::JSON
  has_many :shop_collections, dependent: :destroy

  def convert_from_json(json)
    self.shopper_name = json[:shopper_name]
    self.orders_count = json[:orders_count]
    self.items_count = json[:items_count]
    self.total_time = json[:total_time]

    unless json[:shop_collections].nil?
      self.shop_collections = json[:shop_collections].collect {|x| ShopCollection.new.convert_from_json(x)}
    end

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