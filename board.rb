require_relative 'piece'

class Board < Piece
  attr_accessor :grid

  def self.create_board
    board = Array.new(3) { Array.new() }
    board.each do |row|
      3.times { row << Piece.new }
    end
  end

  def initialize
    @grid = self.class.create_board
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def mark_square(pos, val)
    self[pos].value = val
  end

  def display
    puts "-------------"
    grid.each do |row|
      print "|"
      row.each do |square|
        value = square.value || " "
        print " #{value } |"
      end
      puts ""
      puts "-------------"
    end
  end
end