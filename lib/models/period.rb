class Period
  def initialize(raw_intervals = [])
    @raw_intervals = raw_intervals
    init_intervals
  end

  attr_accessor :points, :intervals

  def add(start_point, end_point)
    build_interval([start_point, end_point])
    self.interval_edges
  end

  def remove(start_point, end_point)
    interval = Interval.new(start_point, end_point)
    interval_tree = IntervalTree::Tree.new(self.intervals)
    intersections = interval_tree.search(interval.range).to_a

    if intersections.any?
      self.intervals -= intersections
      self.intervals.concat(split_intervals(intersections, interval.range))
    end
    #self.intervals.sort_by!(&:min)

    self.interval_edges
  end

  def interval_edges
    self.intervals.uniq.
      map { |interval| [interval.try(:min), interval.try(:max)] }.
      reject { |interval| interval.compact.empty? }
  end

  private

  def init_intervals
    self.intervals = []

    @raw_intervals.each do |i|
      build_interval(i)
    end
  end

  def build_interval(raw_interval)
    raise Exceptions::WrongIntervalFormat if !raw_interval.is_a?(Array) || raw_interval.size != 2

    interval = Interval.new(*raw_interval)
    interval_tree = IntervalTree::Tree.new(self.intervals)
    intersections = interval_tree.search(interval.range).to_a

    if intersections.any?
      self.intervals -= intersections
      self.intervals << merge_intervals(intersections.push(interval.range))
    else
      self.intervals << interval.range
    end

    self.intervals.sort_by!(&:min)
  end

  def merge_intervals(intervals)
    intervals.map(&:min).min...intervals.map(&:max).max + 1
  end

  def split_intervals(intervals, gap)
    interval_min = intervals.map(&:min).min
    interval_max = intervals.map(&:max).max
    if gap.min > interval_min && gap.max < interval_max
      [interval_min...gap.min + 1, gap.max...interval_max + 1]
    elsif gap.min > interval_min && gap.max > interval_max
      [interval_min...gap.min + 1]
    else
      []
    end
  end
end
