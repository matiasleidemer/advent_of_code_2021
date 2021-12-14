require 'minitest/autorun'

class Coordinates
  attr_reader :x, :y, :aim

  def initialize
    @x = 0
    @y = 0
    @aim = 0
  end

  def forward(value)
    @x += value
    @y += @aim * value
  end

  def down(value)
    # @y += value
    @aim += value
  end

  def up(value)
    # @y -= value
    @aim -= value
  end
end

def input
  <<~EOS
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
  EOS
end

def each_coordinate
  input.split("\n").each do |command|
    action, value = command.split(' ')
    yield action, value.to_i
  end
end

def solution
  @coordinates = Coordinates.new

  each_coordinate do |action, value|
    @coordinates.send(action, value)
  end

  @coordinates.x * @coordinates.y
end

class Test < Minitest::Test
  def test_solution
    assert_equal 900, solution
  end
end
