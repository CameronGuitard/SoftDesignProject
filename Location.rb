require_relative "Piece.rb"

#Location object which stores its coordinates and a Piece
class Location
  attr_accessor :coordinates
  attr_reader :piece

  #Creates an instance of Location
  def initialize
    @coordinates = Array.new(2)
    @piece = nil
  end

  #Adds piece to this location 
  def addPiece(piece)
    if piece.instance_of?(Piece) && @piece == nil
      @piece = piece
      @piece.location = self
      return true
    end
    false
  end

  #Returns stored Piece
  def removePiece
    piece = @piece
    @piece = nil
    piece.location = nil
    piece
  end

  #Returns true if Location has no piece
  def isEmpty
    if @piece == nil
      return true
    end
    false
  end

  #Overrides compare
  def ==(other)
    other.instance_of?(Location) &&
    @coordinates[0] == other.coordinates[0] &&
    @coordinates[1] == other.coordinates[1]
  end
end
