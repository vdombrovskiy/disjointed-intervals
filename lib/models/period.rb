class Period
  def initialize(raw_intervals = [])
    @raw_intervals = raw_intervals
    init_intervals
  end

  attr_accessor :intervals
  attr_accessor :points

  def add(start_point, end_point)
    build_interval([start_point, end_point])
    intervals.map(&:values)
  end

  def remove(start_point, end_point)
    remove_interval([start_point, end_point])
    raise NotImplementedError
  end

  def intervals
    result = []
    s = nil

    values = self.points.map(&:value)
    values.each.with_index do |val, idx|
      s ||= val
      e = val

      if values[idx + 1] != val.next
        result << Interval.new(s, e)
        s = values[idx + 1]
      end

      break if s.nil?
    end

    result
  end

  private
  def init_intervals
    self.intervals = []
    self.points = []

    @raw_intervals.each do |i|
      build_interval(i)
    end
  end

  def build_interval(raw_interval)
    raise Exceptions::WrongIntervalFormat if !raw_interval.is_a?(Array) || raw_interval.size != 2

    interval = Interval.new(*raw_interval)
    raise Exceptions::CrossedIntervals if self.intervals.any?{ |i| i.overlaps?(interval) }

    self.points |= interval.points
    self.points.sort_by!(&:value)

    interval
  end

  def remove_interval(raw_interval)
    
  end
end
