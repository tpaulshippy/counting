# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/spec'

describe Counter do
  let(:initial_value) { { number: 0 } }
  let(:counter) { Counter.new(initial_value) }

  let(:user) do
    User.first || User.create!(email: Faker::Internet.email, password: Faker::Internet.password)
  end

  describe '#up' do
    it 'increases the counter by 1 with a comment' do
      counter.up(user.id, 'incrementing counter')
      expect(counter.history.count).must_equal 1
      expect(counter.history.first.comment).must_equal 'incrementing counter'
      expect(counter.history.first.change).must_equal 1
    end
  end

  describe '#down' do
    it 'decreases the counter by 1 with a comment' do
      counter.down(user.id, 'decrementing counter')
      expect(counter.history.count).must_equal 1
      expect(counter.history.first.comment).must_equal 'decrementing counter'
      expect(counter.history.first.change).must_equal(-1)
    end
  end

  describe '#reset' do
    it 'resets the counter to initial value with a comment' do
      counter.up(user.id)
      counter.reset(user.id, 'resetting counter')
      expect(counter.history.count).must_equal 2
      expect(counter.history.last.comment).must_equal 'resetting counter'
      expect(counter.history.last.change).must_equal 0
      expect(counter.number).must_equal 0
    end
  end
end
