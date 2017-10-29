class Period
  def initialize(raw_intervals = [])
    @raw_intervals = raw_intervals
    init_intervals
  end

  attr_accessor :intervals

  def add(start_point, end_point)
    raise NotImplementedError
  end

  def remove(start_point, end_point)
    raise NotImplementedError
  end

  private
  def init_intervals
    self.intervals = []

    @raw_intervals.each do |i|
      self.intervals << Interval.new(*i)
    end
  end
end
