class ShopCollection < ActiveRecord::Base

  belongs_to :shopper_report
  has_many :line_items, dependent: :destroy

  def convert_from_json(json)
    self.name = json[:name]
    self.orders_count = json[:orders_count]
    self.items_count = json[:items_count]
    self.time_taken = json[:time_taken]
    self.start_time = json[:start_time]
    unless json[:line_items].nil?
      self.line_items = json[:line_items].collect {|x| LineItem.new.convert_from_json(x)}
    end

    self
  end

  def quantity_missing
    line_items.inject(0){|sum,e| sum += e.quantity_missing }
  end
  def quantity_substituted
    line_items.inject(0){|sum,e| sum += e.quantity_substituted }
  end
  def quantity_found
    line_items.inject(0){|sum,e| sum += e.quantity_found }
  end

end