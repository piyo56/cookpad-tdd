class Clock
  attr_reader :hour, :min, :sec

  def initialize(hour, min, sec)
    if hour >= 24 || min >= 60 || sec >= 60
      raise ArgumentError
    end
    @hour = hour
    @min = min
    @sec = sec
  end
end

if __FILE__ == $0
  clock = Clock.new(12, 30 ,60)
  p clock
end
