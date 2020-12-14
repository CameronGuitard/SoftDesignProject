require_relative "location"

#Board object which stores locations and pieces
class Board

  #Creates a new instance of board containing empty locations
  def initialize()
    @locations = Array.new(7)
    l00 = Location.new
    l00.coordinates.insert(0, 0, 0)
    l03 = Location.new
    l03.coordinates.insert(0, 0, 3)
    l06 = Location.new
    l06.coordinates.insert(0, 0, 6)
    l11 = Location.new
    l11.coordinates.insert(0, 1, 1)
    l13 = Location.new
    l13.coordinates.insert(0, 1, 3)
    l15 = Location.new
    l15.coordinates.insert(0, 1, 5)
    l22 = Location.new
    l22.coordinates.insert(0, 2, 2)
    l23 = Location.new
    l23.coordinates.insert(0, 2, 3)
    l24 = Location.new
    l24.coordinates.insert(0, 2, 4)
    l30 = Location.new
    l30.coordinates.insert(0, 3, 0)
    l31 = Location.new
    l31.coordinates.insert(0, 3, 1)
    l32 = Location.new
    l32.coordinates.insert(0, 3, 2)
    l34 = Location.new
    l34.coordinates.insert(0, 3, 4)
    l35 = Location.new
    l35.coordinates.insert(0, 3, 5)
    l36 = Location.new
    l36.coordinates.insert(0, 3, 6)
    l42 = Location.new
    l42.coordinates.insert(0, 4, 2)
    l43 = Location.new
    l43.coordinates.insert(0, 4, 3)
    l44 = Location.new
    l44.coordinates.insert(0, 4, 4)
    l51 = Location.new
    l51.coordinates.insert(0, 5, 1)
    l53 = Location.new
    l53.coordinates.insert(0, 5, 3)
    l55 = Location.new
    l55.coordinates.insert(0, 5, 5)
    l60 = Location.new
    l60.coordinates.insert(0, 6, 0)
    l63 = Location.new
    l63.coordinates.insert(0, 6, 3)
    l66 = Location.new
    l66.coordinates.insert(0, 6, 6)
    @locations.insert(0, [l00, nil, nil, l03, nil, nil, l06])
    @locations.insert(1, [nil, l11, nil, l13, nil, l15, nil])
    @locations.insert(2, [nil, nil, l22, l23, l24, nil, nil])
    @locations.insert(3, [l03, l31, l32, nil, l34, l35, l36])
    @locations.insert(4, [nil, nil, l42, l43, l44, nil, nil])
    @locations.insert(5, [nil, l51, nil, l53, nil, l55, nil])
    @locations.insert(6, [l60, nil, nil, l63, nil, nil, l66])
  end

  #Return location at specified coordinates or nil if invalid coordinates
  def selectLocation(x, y)
    if x.instance_of?(Integer) && y.instance_of?(Integer)
      if (x >= 0 && x <= 6) && (y >= 0 && y <= 6)
        return @locations[x][y]
      end
    end
    return nil
  end

  #Return piece at specified coordinates or nil if invalid coordinates (piece is removed from board)
  def selectPiece(x, y)
    if x.instance_of?(Integer) && y.instance_of?(Integer)
      if (x >= 0 && x <= 6) && (y >= 0 && y <= 6)
        return @locations[x][y].removePiece
      end
    end
    return nil
  end

  #Add piece to location if location is empty
  def movePiece(piece, newLocation)
    if piece.instance_of?(Piece) && newLocation.instance_of?(Location)
      if newLocation.isEmpty
        newLocation.addPiece(piece)
        piece.location = newLocation
      end
    end
  end

  #Remove a piece from the board
  def removePiece(piece)
    if piece.instance_of?(Piece) && piece.location != nil
      piece.location.removePiece
      piece.location = nil
    end
  end

  #Checks if location on the board is empty
  def isEmpty(x, y)
    if x.instance_of?(Integer) && y.instance_of?(Integer)
      if (x >= 0 && x <= 6) && (y >= 0 && y <= 6)
        return @locations[x][y].isEmpty
      end
    end
  end

  def isAdjacent(piece, location)
  end

end