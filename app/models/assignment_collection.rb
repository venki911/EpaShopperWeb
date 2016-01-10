class AssignmentCollection < ActiveRecord::Base
  has_many :shopper_assignments
  validates :delivery_date, presence: true, uniqueness: {case_sensitive: false}
end

