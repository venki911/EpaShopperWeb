class OrderAssignment < ActiveRecord::Base
  # Contains list of orders assignment to each shopper in a shopper assignment
  has_many :shopper_assignments, through: :shopper_assignments_order_assignments

end