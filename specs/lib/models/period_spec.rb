describe Period do
  context 'methods' do
    subject { Period.new() }

    it 'has intervals' do
      subject.must_respond_to :intervals
    end

    it 'can add an interval' do
      subject.must_respond_to :add
    end

    it 'can remove an interval' do
      subject.must_respond_to :remove
    end
  end

  context '.add' do
    subject { Period.new() }

    context 'positive cases' do

      it 'can add an interval' do
        subject.add(1,3).must_equal [[1,3]]
      end

      it 'can add two intervals' do
        subject.add(1,3)
        subject.add(4,6).must_equal [[1,3], [4,6]]
      end

      it 'can merge intervals' do
        subject.add(1, 5)
        subject.intervals.map(&:values).must_equal [[1, 5]]

        subject.remove(2, 3)
        subject.intervals.map(&:values).must_equal [[1, 2], [3, 5]]

        subject.add(6, 8)
        subject.intervals.map(&:values).must_equal [[1, 2], [3, 5], [6, 8]]

        subject.remove(4, 7)
        subject.intervals.map(&:values).must_equal [[1, 2], [3, 4], [7, 8]]

        subject.add(2, 7)
        subject.intervals.map(&:values).must_equal [[1, 8]]
      end
    end

    context 'negative cases' do
      it 'does not accept interval with start after the end' do
        Proc.new do
          subject.add(3,1)
        end.must_raise Exceptions::IntervalStartAfterEnd
      end

      it 'does not accept interval with start equal to end' do
        Proc.new do
          subject.add(3,3)
        end.must_raise Exceptions::IntervalStartEqualToEnd
      end
    end
  end

  context '.remove' do
    subject { Period.new() }

    before :each do
      subject.add(1,5)
    end

    context 'positive cases' do
      it 'removes interval correctly' do
        subject.remove(2,3).must_equal [[1, 2], [3, 5]]
      end
    end

    context 'negative cases' do
      it 'does not accept interval with start after the end' do
        Proc.new do
          subject.remove(3,1)
        end.must_raise Exceptions::IntervalStartAfterEnd
      end

      it 'does not accept interval with start equal to end' do
        Proc.new do
          subject.remove(3,3)
        end.must_raise Exceptions::IntervalStartEqualToEnd
      end
    end
  end

  context 'positive cases' do
    it 'creates empty period by default' do
      Period.new.intervals.must_be_empty
    end

    it 'fills points if passed' do
      Period.new([[1,3], [4,6]]).points.size.must_equal 4
    end

    it 'fills intervals if passed' do
      Period.new([[1,3], [4,6]]).intervals.size.must_equal 2
      Period.new([[1,3], [4,6]]).intervals.map(&:values).must_equal [[1,3], [4,6]]
    end

    it 'correctly fills divided intervals' do
      Period.new([[1,3], [5,10]]).intervals.size.must_equal 2
    end

    it 'correctly fills non integer values' do
      Period.new([['1',3], [5.3,10]]).intervals.size.must_equal 2
    end
  end

  context 'negative cases' do
    it 'does not accept interval with start after the end' do
      Proc.new do
        Period.new([[3,1]])
      end.must_raise Exceptions::IntervalStartAfterEnd
    end

    it 'does not accept interval with start equal to end' do
      Proc.new do
        Period.new([[3,3]])
      end.must_raise Exceptions::IntervalStartEqualToEnd
    end

    it 'accepts interval only as Array' do
      wrong_formats = {
        integer: [1, [2,3]],
        string: [[2,3], '1'],
        nil: [nil, [2,3]],
        float: [[2,3], 1.3],
        negative: [[2,3], -4],
        hash: [[2,3], { key: :value }]
      }

      wrong_formats.values.each do |intervals|
        Proc.new do
          Period.new(intervals)
        end.must_raise Exceptions::WrongIntervalFormat
      end
    end

    it 'does not accept interval with more then two points' do
      Proc.new do
        Period.new([[1,2,3]])
      end.must_raise Exceptions::WrongIntervalFormat
    end

    it 'does not accept interval with points non castable to integer' do
      Proc.new do
        Period.new([[1,{}]])
      end.must_raise Exceptions::WrongIntervalFormat
    end

    it 'does not accept interval with less than two points' do
      Proc.new do
        Period.new([[3]])
      end.must_raise Exceptions::WrongIntervalFormat
    end

    it 'accepts interval with two points only' do
      Proc.new do
        Period.new([[1,2,3]])
      end.must_raise Exceptions::WrongIntervalFormat
    end
  end
end
