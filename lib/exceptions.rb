module Exceptions
  class Base < StandardError
  end

  class IntervalStartAfterEnd < Base
    def message
      'Start point can not be after the end point'
    end
  end

  class IntervalStartEqualToEnd < Base
    def message
      'Start point can not be same as the end point'
    end
  end

  class WrongIntervalFormat < Base
    def message
      'Wrong interval format. Should be array with 2 integers. Example: [1,2]'
    end
  end

  class WrongPointFormat < Base
    def message
      'Wrong point format. Should be an positive integer'
    end
  end
end
