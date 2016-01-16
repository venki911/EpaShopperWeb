class ShopperAssignment < ActiveRecord::Base
  belongs_to :assignment_collection
  belongs_to :shopper
  has_many :store_assignments, dependent: :destroy
  has_many :order_assignments, dependent: :destroy

  def convert_to_json
    {
        shopper: shopper.username,
        store_assignments: store_assignments.collect{|x| x.name},
        order_assignments: order_assignments.collect{|x| x.name}
    }
  end

  def convert_from_json(json)

    self.shopper = Shopper.find_by(username: json[:shopper])

    unless json[:store_assignments].nil?
      self.store_assignments = json[:store_assignments].collect { |x| StoreAssignment.new(name: x) }
    end

    unless json[:order_assignments].nil?
      self.order_assignments = json[:order_assignments].collect { |x| OrderAssignment.new(name: x) }
    end

    self
  end

end