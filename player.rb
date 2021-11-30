class Player
  attr_reader :name, :letter

  def initialize(name, letter)
    @name, @letter = name, letter
  end
end