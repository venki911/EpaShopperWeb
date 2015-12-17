class LineItem < ActiveRecord::Base
  belongs_to :shop_collection

  def initialize(json: json)
    super()



  end

end