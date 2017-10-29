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

    @raw_intervals.each do |points|
      raise Exceptions::WrongIntervalFormat if !points.is_a?(Array) || points.size != 2

      pretendent = Interval.new(*points)
      raise Exceptions::CrossedIntervals if self.intervals.any?{ |i| i.overlaps?(pretendent) }

      self.intervals << pretendent
    end
  end
end
