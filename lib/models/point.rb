class Point
  def initialize(start_point, end_point)
    @start_point = start_point.try(:to_i) || (raise Exceptions::WrongPointFormat)
    @end_point = end_point.try(:to_i) || (raise Exceptions::WrongPointFormat)
  end

  attr_accessor :start_point, :end_point
end
