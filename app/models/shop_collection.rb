class ShopCollection < ActiveRecord::Base

  include ActiveModel::Serializers::JSON
  belongs_to :shopper_report
  has_many :line_items, dependent: :destroy

  def convert_from_json(json)
    self.name = json[:name]
    self.orders_count = json[:orders_count]
    self.items_count = json[:items_count]
    self.time_taken = json[:time_taken]
    unless json[:line_items].nil?
      self.line_items = json[:line_items].collect {|x| LineItem.new.convert_from_json(x)}
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