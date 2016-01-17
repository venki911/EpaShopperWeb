require 'date'

class Order

  DELIVERY_DATE_PRIVATE_KEY = 'DeliveryDatePrivate'
  DELIVERY_DATE_BUSINESS_KEY = 'DeliveryDateBusiness'

  attr_accessor :id, :name, :fulfillment_status, :order_date, :note

  def convert_from_json(json)

    self.id = json[:id]
    self.name = "Order #{json[:name]}"
    self.fulfillment_status = json[:fulfillment_status]
    self.note = json[:note]

    unless json[:note_attributes].nil? || json[:note_attributes].empty?
      json[:note_attributes].each do |attribute|

        if attribute[:name] == DELIVERY_DATE_PRIVATE_KEY || attribute[:name] == DELIVERY_DATE_BUSINESS_KEY
          unless attribute[:value].nil? || attribute[:value].empty?
            self.order_date = DateTime.strptime(attribute[:value], '%d-%b-%Y')
          end
        end

      end

    end

    if self.order_date.nil? && !note.empty?
      begin
        self.order_date = DateTime.strptime(note, '%d-%b-%Y')
      rescue
        self.order_date = nil
      end
    end

    self
  end

  def for_date?(target_date)
    !order_date.nil? && !target_date.nil? && order_date.to_date == target_date.to_date
  end

  def for_today?
    for_date?(DateTime.now)
  end


end
