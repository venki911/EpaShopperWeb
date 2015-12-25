module ApplicationHelper

  def timer_string(ticks)
    seconds = ticks % 60
    minutes = ((ticks - seconds)/60)%60
    hours = (ticks - seconds - minutes * 60)/3600

    "#{append_leading_zero hours}:#{append_leading_zero minutes}:#{append_leading_zero seconds}"
  end

  def logo_for_store(name)
    case name.downcase
      when 'costco'
        'costco_logo.png'
      when 'loblaws'
        'loblaws_logo.png'
      else
        'epa_logo.png'
    end
  end


  def format_report_datetime(date)
    date.in_time_zone('EST').strftime('%d-%b-%Y %I:%M %p')
  end
  def format_report_date(date, separator: ' ')
    "#{date.in_time_zone('EST').strftime('%d %b.')}#{separator}#{date.in_time_zone('EST').strftime('%Y')}"
  end

  def quantity_percentage(num1, num2:, value_if_div_by_zero: 0)
    if num2 == 0
      return "#{value_if_div_by_zero}%"
    end

    "#{(Float(num1)/num2*100).round(0)}%"
  end

  private
    def append_leading_zero(num)
      num < 10 ? "0#{num}" : num
    end

end
