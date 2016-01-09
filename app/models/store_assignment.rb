class StoreAssignment < ActiveRecord::Base
  # Contains list of stores assignment to each shopper in an assignment
  has_many :shopper_assignments, through: :shopper_assignments_store_assignments

end