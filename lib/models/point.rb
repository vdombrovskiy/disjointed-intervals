class Point
  def initialize(value)
    @value = value.try(:to_i) || (raise Exceptions::WrongPointFormat)
  end

  attr_accessor :value
end
