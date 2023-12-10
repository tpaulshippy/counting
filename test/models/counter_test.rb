require "minitest/autorun"
require "minitest/spec"

describe "Counter" do
  let(:counter) { Counter.new(number: 0) }
  describe "#up" do

    before do
      counter.up
    end

    it "adds 1 to the number" do
      assert_equal 1, counter.number
    end
    
    it "records a history of the increase" do
      assert_equal 1, counter.number
      assert_equal 1, counter.history.count
      assert_equal 1, counter.history.first.change
    end
  end
  
  describe "#down" do

    before do
      counter.down
    end

    it "subtracts 1 from the number" do
      assert_equal -1, counter.number
    end

    it "records a history of the decrease" do
      assert_equal 1, counter.history.count
      assert_equal -1, counter.history.first.change
    end
  end

  describe "#reset" do
    let (:counter) { Counter.new(number: 1) }
    before do
      counter.reset
    end
    it "sets the number to 0" do
      assert_equal 0, counter.number
    end

    it "records a history of the reset" do
      assert_equal 1, counter.history.count
      assert_equal 0, counter.history.first.change
    end
  end
end
