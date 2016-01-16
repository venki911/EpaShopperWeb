class StoreAssignment < ActiveRecord::Base
  # Contains list of stores assignment to each shopper in an assignment
  belongs_to :shopper_assignment

end