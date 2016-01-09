class Shopper < ActiveRecord::Base
  has_many :shopper_assignments
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:3, maximum:25}
  validates :password, presence: true, length: {minimum: 3, maximum: 25}
  before_save {self.username = username.downcase}

  has_secure_password
end