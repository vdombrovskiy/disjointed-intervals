class Period
  def initialize(raw_intervals = [])
    @raw_intervals = raw_intervals
    init_intervals
  end

  attr_accessor :intervals

  def add(start_point, end_point)
    self.intervals << build_interval([start_point, end_point])
  end

  def remove(start_point, end_point)
    raise NotImplementedError
  end

  private
  def init_intervals
    self.intervals = []

    @raw_intervals.each do |points|
      self.intervals << build_interval(points)
    end
  end

  def build_interval(points)
    raise Exceptions::WrongIntervalFormat if !points.is_a?(Array) || points.size != 2

    pretendent = Interval.new(*points)
    raise Exceptions::CrossedIntervals if self.intervals.any?{ |i| i.overlaps?(pretendent) }

    pretendent
  end
end
