class ShopperAssignment < ActiveRecord::Base
  belongs_to :assignment_collection
  belongs_to :shopper
  has_many :store_assignments, through: :shopper_assignments_store_assignments
  has_many :order_assignments, through: :shopper_assignments_order_assignments
end