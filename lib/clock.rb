class Clock
  attr_reader :hour, :min, :sec

  def initialize(hour, min, sec)
    @hour = verify_valid_clock_input(hour, 24)
    @min  = verify_valid_clock_input(min, 60)
    @sec  = verify_valid_clock_input(sec, 60)
  end

  def to_time(date)
    Time.local(date.year, date.month, date.day, @hour, @min, @sec)
  end

  def next_time(time)
    return time + (60 * 60 * 24)
  end

  def previous_time(time)
    return time - (60 * 60 * 24)
  end

  def next_wday(time, wday, hour, min)
    all_wday_nums = {
      "Sun" => 0,
      "Mon" => 1,
      "Tue" => 2,
      "Wed" => 3,
      "Thu" => 4,
      "Fri" => 5,
      "Sat" => 6
    }
    wday_num = all_wday_nums[wday]
  
    a_day = 60 * 60 * 24
    (0..7).each do |i|
      _time = time + i * a_day
      if _time.wday == wday_num
        next_wday_time = Time.new(_time.year, _time.month, _time.day, hour, min, 0)
        if time < next_wday_time
          return next_wday_time
        end
      end
    end
  end
  
  private 
  def verify_valid_clock_input(val, max)
    if (0...max).include?(val)
      return val
    else
      raise ArgumentError
    end
  end
end


if __FILE__ == $0
  clock = Clock.new(12, 30 ,60)
  p clock
end
