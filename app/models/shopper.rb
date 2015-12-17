class Shopper < ActiveRecord::Base

  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:3, maximum:25}
  before_save {self.username = email.username}

  has_secure_password
end