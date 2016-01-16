class OrderAssignment < ActiveRecord::Base
  # Contains list of orders assignment to each shopper in a shopper assignment
  belongs_to :shopper_assignment

end