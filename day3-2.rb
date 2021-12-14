require 'minitest/autorun'

def group(readings, position)
  ones = []
  zeroes = []
  i = 0

  while i < readings.size
    if readings[i][position] == '1'
      ones.push(readings[i])
    else
      zeroes.push(readings[i])
    end

    i += 1
  end

  [zeroes, ones]
end

def oxygen_generator_rating(readings, position = 0)
  return readings.first.to_i(2) if readings.size == 1

  zeroes, ones = group(readings, position)

  if zeroes.size == ones.size
    oxygen_generator_rating(ones, position + 1)
  elsif ones.size > zeroes.size
    oxygen_generator_rating(ones, position + 1)
  else
    oxygen_generator_rating(zeroes, position + 1)
  end
end

def co2_scrubber_rating(readings, position = 0)
  return readings.first.to_i(2) if readings.size == 1

  zeroes, ones = group(readings, position)

  if zeroes.size == ones.size
    co2_scrubber_rating(zeroes, position + 1)
  elsif ones.size > zeroes.size
    co2_scrubber_rating(zeroes, position + 1)
  else
    co2_scrubber_rating(ones, position + 1)
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

def solution
  arr_input = input.split("\n")

  oxygen_generator_rating(arr_input) * co2_scrubber_rating(arr_input)
end

class Test < Minitest::Test
  def test_solution
    assert_equal 230, solution
  end
end
