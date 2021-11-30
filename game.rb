require_relative "player"
require_relative "board"

class Game
  attr_accessor :current_player
  attr_reader :board, :players

  def self.create_players
    [Player.new("Player 1", "X"), Player.new("Player 2", "O")]
  end

  def initialize
    @board = Board.new
    @players = Game.create_players
    @current_player = @players[1]
  end

  def switch_player
    if current_player == @players[0]
      @current_player = @players[1]
    else
      @current_player = @players[0]
    end
  end

  def valid_move?(pos)
    x, y = pos
    return false unless x.class == Integer && y.class == Integer
    board[pos].empty?
  end

  def get_move
    move = []
    until valid_move?(move)
      puts "It is your turn #{current_player.name}, which open square would you like to mark? ex. '0,1' '2,2'. Anything not a number is converted to 0."
      move = gets.chomp.split(",")
      move.map!(&:to_i)
    end
    board.mark_square(move, current_player.letter)
  end

  def play
    until win? || over?
      switch_player
      board.display
      get_move
    end

    board.display
    if win?
      puts "Congratulations #{current_player.name}! You have won the game!"
    else
      draw
    end
  end

  def over?
    board.full?
  end

  def draw
    puts "Draw! neither player has won the game!"
  end

  def win?
    diagonal_win? || vertical_win? || horizontal_win?
  end

  def diagonal_win?
    left_down = [[0,0], [1,1], [2,2]]
    left_up = [[2,0], [1,1], [0,2]]
    all_equal?(left_down) || all_equal?(left_up)
  end

  def vertical_win?
    (0..2).each do |y|
      values = []
      (0..2).each do |x|
        values << [x, y]
      end
      return true if all_equal?(values)
    end
    false
  end

  def horizontal_win?
    (0..2).each do |x|
      values = []
      (0..2).each do |y|
        values << [x, y]
      end
      return true if all_equal?(values)
    end
    false
  end

  def all_equal?(arr)
    values = arr.map { |square| board[square].value }
    return false if values.any? { |val| val.nil? }
    values.uniq.size <= 1
  end
end