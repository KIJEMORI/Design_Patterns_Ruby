require_relative 'class_for_processing_Array'
require 'minitest/autorun'

class Tests < Minitest::Test
  attr_reader :processor

  def setup
    array = [1,2,3,4,5,6,1,3,5,3,567,12]
    @processor = Processing.new(array)
  end

  def test_drop_while!
      assert_equal [3,4,5,6,1,3,5,3,567,12], @processor.drop_while!() { |x| x != 3}
  end

  def test_max
      assert_equal 567, @processor.max(){|a,b| a <=> b}
  end

  def test_sort!
      assert_equal [1, 1, 2, 3, 3, 3, 4, 5, 5, 6, 12, 567], @processor.sort!(){|a,b| a < b}
  end

  def test_select
      assert_equal [4, 5, 6, 5, 567, 12], @processor.select(){|x| x > 3}
  end

  def test_map
      assert_equal [3, 4, 5, 6, 7, 8, 3, 5, 7, 5, 569, 14], @processor.map(){|x| x + 2}
  end

  def test_detect
      assert_equal 4, @processor.detect(){|x| x > 3 and x < 10}
  end

  private
  attr_writer :processor
end