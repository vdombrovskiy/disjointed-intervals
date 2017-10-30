class Period
  def initialize(raw_intervals = [])
    @raw_intervals = raw_intervals
    init_intervals
  end

  attr_accessor :points

  def add(start_point, end_point)
    build_interval([start_point, end_point])
    self.intervals.map(&:values)
  end

  def remove(start_point, end_point)
    interval = Interval.new(start_point, end_point)

    self.points.reject!{ |pt| pt.start_point.in?(interval.range) && pt.end_point.in?(interval.range) }
    self.intervals.map(&:values)
  end

  def intervals
    result = []
    s = nil

    self.points.each.with_index do |pt, idx|
      s ||= pt.start_point
      e = pt.end_point

      if self.points[idx + 1].try(:start_point) != e
        result << Interval.new(s, e)
        s = self.points[idx + 1].try(:start_point)
      end

      break unless self.points[idx + 1]
    end

    result
  end

  private
  def init_intervals
    self.points = []

    @raw_intervals.each do |i|
      build_interval(i)
    end
  end

  def build_interval(raw_interval)
    raise Exceptions::WrongIntervalFormat if !raw_interval.is_a?(Array) || raw_interval.size != 2

    interval = Interval.new(*raw_interval)

    Range.new(*interval.values).each_cons(2).each do |pair|
      self.points << Point.new(*pair)
    end

    self.points.sort_by!(&:start_point).uniq!{ |pt| [pt.start_point, pt.end_point] }

    interval
  end
end
