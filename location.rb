require_relative "piece"

#Location object which stores its coordinates and a Piece
class Location
  attr_accessor :coordinates

  #Creates an instance of Location
  def initialize()
    @coordinates = Array.new(2)
    @piece = nil
  end

  #Adds piece to this location 
  def addPiece(piece)
    if piece.instance_of? Piece && @piece == nil
      @piece = piece
      return true
    end
    false
  end

  #Returns stored Piece
  def removePiece()
    piece = @piece
    @piece = nil
    piece
  end

  #Returns true if Location has no piece
  def isEmpty()
    if @piece == nil
      return true
    end
    false
  end
end