describe Interval do
  context 'overlaps?' do
  end

  context 'points' do
    it 'returns one point for minimal interval' do
      Interval.new(2, 3).points.map(&:value).must_equal [2,3]
    end

    it 'returns two points for interval with two points' do
      Interval.new(2, 4).points.map(&:value).must_equal [2,3,4]
    end
  end
end
