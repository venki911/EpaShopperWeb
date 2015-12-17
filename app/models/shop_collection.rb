class ShopCollection < ActiveRecord::Base
  belongs_to :shopper_report

  def initialize(json: json)
    super()



  end

end