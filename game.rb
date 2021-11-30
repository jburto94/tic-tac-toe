require_relative "player"
require_relative "board"

class Game
  attr_accessor :current_player

  def self.create_players
    [Player.new("Player 1", "X"), Player.new("Player 2", "O")]
  end

  def initialize
    @board = Board.new
    @players = Game.create_players
    @current_player = @players[0]
  end

  def switch_player
    if current_player == @players[0]
      @current_player = @players[1]
    else
      @current_player = players[0]
    end
  end

  def valid_move?(pos)
    board[pos].empty?
  end

  def get_move
    move = ""
    until valid_move?(move)
      puts "Which open square would you like to mark? ex. '[0,1] or [2,2]'"
      move = gets.chomp
    end
    move
  end
end