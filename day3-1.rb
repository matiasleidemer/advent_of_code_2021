require 'minitest/autorun'

class PowerConsumption
  def initialize(readings)
    # [
    # [1, 0, ...],
    # [0, 0, ...],
    # [0, 1, ...]
    # ]
    @readings = readings
  end

  def gamma_rate
    @readings.each_with_object([]) do |reading, output|
      if reading.count(&:zero?) > (reading.size / 2)
        output.push(0)
      else
        output.push(1)
      end
    end.join('').to_i(2)
  end

  def epsilon_rate
    @readings.each_with_object([]) do |reading, output|
      if reading.count(&:zero?) < (reading.size / 2)
        output.push(0)
      else
        output.push(1)
      end
    end.join('').to_i(2)
  end
end

def input
  <<~EOS
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
  EOS
end

def transposed_input
  input.split("\n").map { |arr| arr.split('').map(&:to_i) }.transpose
end

def solution
  @pc = PowerConsumption.new(transposed_input)
  @pc.gamma_rate * @pc.epsilon_rate
end

class Test < Minitest::Test
  def test_solution
    assert_equal 198, solution
  end
end
