class Piece
  attr_accessor :value
  def initialize(value=nil)
    @value = value
  end

  def empty?
    value.nil?
  end
end