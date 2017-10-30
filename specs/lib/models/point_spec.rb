describe Point do

	context 'methods' do
		subject { Point.new(1,2) }

    it 'has start point' do
      subject.must_respond_to :start_point
    end

    it 'has end point' do
      subject.must_respond_to :end_point
    end
  end

	it 'accepts integer arguments' do
		point = Point.new(2,3)
		point.start_point.must_equal 2
		point.end_point.must_equal 3
	end

	it 'accespts castable to integer arguments' do
		point = Point.new('1', 2.0)
		point.start_point.must_equal 1
		point.end_point.must_equal 2
	end

  it 'does not accept point with invalid first argument' do
    proc do
      Point.new({}, 1)
    end.must_raise Exceptions::WrongPointFormat
  end

  it 'does not accept point with invalid second argument' do
    Proc.new do
      Point.new(1, {})
    end.must_raise Exceptions::WrongPointFormat
  end
end


