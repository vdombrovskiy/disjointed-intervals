describe Period do
  context 'methods' do
    subject { Period.new }

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
    subject { Period.new }

    context 'positive cases' do
      it 'can add an interval' do
        subject.add(1, 3).must_equal [[1, 3]]
      end

      it 'can add an interval with negative value' do
        subject.add(1, 3).must_equal [[1, 3]]
        subject.add(-3, 0).must_equal [[-3, 0], [1, 3]]
      end

      it 'can add overlapped intervals' do
        subject.add(1, 3).must_equal [[1, 3]]
        subject.add(2, 4).must_equal [[1, 4]]
      end

      it 'can add two intervals' do
        subject.add(1, 3).must_equal [[1, 3]]
        subject.add(4, 6).must_equal [[1, 3], [4, 6]]
      end

      it 'can add same interval twice' do
        subject.add(1, 3).must_equal [[1, 3]]
        subject.add(1, 3).must_equal [[1, 3]]
      end

      it 'can accept non integer values' do
        subject.add('1', 3).must_equal [[1, 3]]
        subject.add('-4ddd', 5.4).must_equal [[-4, 5]]
      end

      it 'can merge intervals' do
        subject.add(1, 5).must_equal [[1, 5]]
        subject.remove(2, 3).must_equal [[1, 2], [3, 5]]
        subject.add(6, 8).must_equal [[1, 2], [3, 5], [6, 8]]
        subject.remove(4, 7).must_equal [[1, 2], [3, 4], [7, 8]]
        subject.add(2, 7).must_equal [[1, 8]]
      end
    end

    context 'negative cases' do
      it 'does not accept interval with start after the end' do
        proc do
          subject.add(3, 1)
        end.must_raise Exceptions::IntervalStartAfterEnd
      end

      it 'does not accept interval with start equal to end' do
        proc do
          subject.add(3, 3)
        end.must_raise Exceptions::IntervalStartEqualToEnd
      end

      it 'does not accept interval with points non castable to integer' do
        proc do
          subject.add(3, {})
        end.must_raise Exceptions::WrongIntervalFormat
      end
    end
  end

  context '.remove' do
    subject { Period.new }

    before :each do
      subject.add(1, 5)
    end

    context 'positive cases' do
      it 'removes interval correctly' do
        subject.remove(2, 3).must_equal [[1, 2], [3, 5]]
      end

      it 'removes interval with negative value' do
        subject.add(-5, 3).must_equal [[-5, 5]]
        subject.remove(-3, 0).must_equal [[-5, -3], [0, 5]]
      end

      it 'removes interval which is out of bounds' do
        subject.remove(2, 7).must_equal [[1, 2]]
        subject.remove(0, 4).must_equal []
        subject.add(1,5).must_equal [[1,5]]
        subject.remove(0,4).must_equal [[4,5]]
      end

      it 'removes few intervals at once' do
        subject.add(6, 8)
        subject.add(9, 11).must_equal [[1, 5], [6, 8], [9, 11]]
        subject.remove(2, 10).must_equal [[1, 2], [10, 11]]
      end
    end

    context 'negative cases' do
      it 'does not accept interval with start after the end' do
        proc do
          subject.remove(3, 1)
        end.must_raise Exceptions::IntervalStartAfterEnd
      end

      it 'does not accept interval with start equal to end' do
        proc do
          subject.remove(3, 3)
        end.must_raise Exceptions::IntervalStartEqualToEnd
      end
    end
  end

  context 'positive cases' do
    it 'creates empty period by default' do
      Period.new.intervals.must_be_empty
    end

    it 'fills edge intervals' do
      intervals = Period.new([[1, 3], [4, 6]]).interval_edges
      intervals.size.must_equal 2
      intervals.must_equal [[1, 3], [4, 6]]
    end

    it 'correctly fills divided intervals' do
      Period.new([[1, 3], [5, 10]]).interval_edges.size.must_equal 2
    end

    it 'correctly fills non integer values' do
      Period.new([['1', 3], [5.3, 10]]).interval_edges.size.must_equal 2
    end
  end

  context 'negative cases' do
    it 'does not accept interval with start after the end' do
      proc do
        Period.new([[3, 1]])
      end.must_raise Exceptions::IntervalStartAfterEnd
    end

    it 'does not accept interval with start equal to end' do
      proc do
        Period.new([[3, 3]])
      end.must_raise Exceptions::IntervalStartEqualToEnd
    end

    it 'accepts interval only as Array' do
      wrong_formats = {
        integer: [1, [2, 3]],
        string: [[2, 3], '1'],
        nil: [nil, [2, 3]],
        float: [[2, 3], 1.3],
        hash: [[2, 3], { key: :value }]
      }

      wrong_formats.values.each do |intervals|
        proc do
          Period.new(intervals)
        end.must_raise Exceptions::WrongIntervalFormat
      end
    end

    it 'does not accept interval with more then two points' do
      proc do
        Period.new([[1, 2, 3]])
      end.must_raise Exceptions::WrongIntervalFormat
    end

    it 'does not accept interval with points non castable to integer' do
      proc do
        Period.new([[1, {}]])
      end.must_raise Exceptions::WrongIntervalFormat
    end

    it 'does not accept interval with less than two points' do
      proc do
        Period.new([[3]])
      end.must_raise Exceptions::WrongIntervalFormat
    end

    it 'accepts interval with two points only' do
      proc do
        Period.new([[1, 2, 3]])
      end.must_raise Exceptions::WrongIntervalFormat
    end
  end
end
