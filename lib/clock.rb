class Clock
  attr_reader :hour, :min, :sec

  def initialize(hour, min, sec)
    @hour = verify_valid_clock_input(hour, 24)
    @min  = verify_valid_clock_input(min, 60)
    @sec  = verify_valid_clock_input(sec, 60)
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
