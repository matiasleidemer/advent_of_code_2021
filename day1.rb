require 'minitest/autorun'

def input
  %w[199 200 208 210 200 207 240 269 260 263]
end

def solution1(measurements)
  measurements.zip(measurements.drop(1)).count do |pair|
    pair[1].to_i > pair[0].to_i
  end
end

def solution2(measurements)
  number_measurements = measurements.map(&:to_i)

  normalized_measurements = number_measurements
                            .map.with_index { |_, i| number_measurements.slice(i, 3) }
                            .filter { |items| items.size == 3 }
                            .map(&:sum)

  solution1(normalized_measurements)
end

class Test < Minitest::Test
  def test_solution1
    assert_equal 7, solution1(input)
  end

  def test_solution2
    assert_equal 5, solution2(input)
  end
end
