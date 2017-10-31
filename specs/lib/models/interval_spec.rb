describe Interval do

  context '.values' do
    it 'returns array with start/end elements' do
      Interval.new(2, 3).values.must_equal [2,3]
    end
  end

  context '.range' do
    it 'returns range with start/end boundaries' do
      Interval.new(2,3).range.must_equal (2...4)
    end
  end

  context 'negative cases' do
    it 'does not accept start after the end' do
      proc do
        Interval.new(3,1)
      end.must_raise Exceptions::IntervalStartAfterEnd
    end

    it 'does not accept start equal to end' do
      proc do
        Interval.new(1,1)
      end.must_raise Exceptions::IntervalStartEqualToEnd
    end
  end
end
