require "minitest/autorun"
require "minitest/spec"

describe "Counter" do
  describe "#up" do
    it "adds 1 to the number" do
      counter = Counter.new(number: 0)
      counter.up
      assert_equal 1, counter.number
    end
  end
  describe "#down" do
    it "subtracts 1 from the number" do
      counter = Counter.new(number: 0)
      counter.down
      assert_equal -1, counter.number
    end
  end
  describe "#reset" do
    it "sets the number to 0" do
      counter = Counter.new(number: 1)
      counter.reset
      assert_equal 0, counter.number
    end
  end
end
