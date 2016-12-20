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

  def next_time(time, wday = -1)
    all_wdays = (1..7).to_a
    clock_time= Time.local(time.year, time.month, time.day, @hour, @min, @sec)
    
    # 与えられれたtimeと同日の場合
    if wday == -1 || clock_time.wday == time.wday
      if time < clock_time
        return clock_time
      end
    end
    
    # それ以降の場合
    a_day = 60 * 60 * 24
    7.times do
      clock_time += a_day
      if wday == -1 || clock_time.wday == wday
        return clock_time
      end
    end
  end

  def previous_time(time)
    return time - (60 * 60 * 24)
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
