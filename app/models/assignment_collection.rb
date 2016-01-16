require 'json'

class AssignmentCollection < ActiveRecord::Base
  has_many :shopper_assignments, dependent: :destroy
  validates :delivery_date, presence: true, uniqueness: {case_sensitive: false}

  def convert_to_json

    {
        delivery_date: format_assignment_date(delivery_date, separator: "\n"),
        created_at: format_assignment_date(created_at, separator: ' '),
        updated_at: format_assignment_date(updated_at, separator: ' '),
        shopper_assignments: shopper_assignments.nil? || shopper_assignments.empty? ? [] : shopper_assignments.collect{|x| x.convert_to_json}
    }
  end

  def update_shopper_assignments(json)

    self.shopper_assignments.each do |assignment|
      assignment.delete
    end

    unless json.nil?
      self.shopper_assignments = json.collect{|x| ShopperAssignment.new.convert_from_json(x)}
    end

  end


  private
    def format_assignment_date(date, separator: ' ')
      "#{date.in_time_zone('EST').strftime('%d %b.')}#{separator}#{date.in_time_zone('EST').strftime('%Y')}"
    end

end

