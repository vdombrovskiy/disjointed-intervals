class Interval
  def initialize(start_point, end_point)
    @start_point = start_point.try(:to_i) || (raise Exceptions::WrongIntervalFormat)
    @end_point = end_point.try(:to_i) || (raise Exceptions::WrongIntervalFormat)

    raise Exceptions::IntervalStartEqualToEnd if @start_point == @end_point
    raise Exceptions::IntervalStartAfterEnd if @start_point > @end_point
  end

  attr_accessor :start_point, :end_point

  def values
    [self.start_point, self.end_point]
  end

  def range
    #(start...end + 1) needed for correct search of interval intersections
    #https://github.com/misshie/interval-tree
    self.start_point...self.end_point + 1
  end
end
