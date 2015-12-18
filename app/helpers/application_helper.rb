module ApplicationHelper

  def timer_string(ticks)
    seconds = ticks % 60
    minutes = ((ticks - seconds)/60)%60
    hours = (ticks - seconds - minutes * 60)/3600
    "#{hours}:#{minutes}:#{seconds}"
  end

  def logo_for_store(name)
    case name.downcase
      when 'Costco'
        'assets/images/costco_logo.png'
      when 'Loblaws'
        'assets/images/costco_logo.png'
      else
        'assets/images/epa_logo.png'
    end
  end

end
