require 'minitest/autorun'

class Boards
  attr_reader :boards

  def initialize(boards)
    @boards = []

    boards.each_with_index do |numbers, index|
      @boards.push(Board.new(numbers, index + 1))
    end
  end

  def mark(number)
    @boards.each { |board| board.mark(number) }
  end

  def winner
    @boards.find(&:winner?)
  end
end

class Board
  attr_reader :numbers, :id, :size, :marks

  def initialize(numbers, id)
    @numbers = numbers
    @id = id
    @size = numbers.first.size
    @marks = {}
  end

  def mark(number)
    (0...size).each do |row|
      (0...size).each do |col|
        if numbers[row][col] == number
          @marks[number] = [row, col]
          break
        end
      end
    end
  end

  def winner?
    rows = @marks.values.map(&:first).tally.values
    cols = @marks.values.map(&:last).tally.values

    rows.any? { |qtd| qtd == 5 } || cols.any? { |qtd| qtd == 5 }
  end

  def score
    unmarked_sum = 0
    last_number = marks.keys.last.to_i

    (0...size).each do |row|
      (0...size).each do |col|
        number = numbers[row][col]
        marked = @marks[number]

        unmarked_sum += number.to_i unless marked
      end
    end

    unmarked_sum * last_number
  end
end

def input
  <<~EOS
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
     8  2 23  4 24
    21  9 14 16  7
     6 10  3 18  5
     1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
     2  0 12  3  7
  EOS
end

def numbers_from_input
  input.split("\n").first.split(',')
end

def boards_from_input
  input
    .split("\n")
    .slice(2, input.split("\n").size)
    .map { |n| n.strip.split(' ') }
    .reject(&:empty?)
    .each_slice(5)
    .to_a
end

def solution
  @boards = Boards.new(boards_from_input)

  numbers_from_input.each do |number|
    @boards.mark(number)
    return @boards.winner.score if @boards.winner
  end
end

class Test < Minitest::Test
  def test_solution
    assert_equal 4512, solution
  end
end
