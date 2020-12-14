require_relative "Location.rb"
require_relative "Piece.rb"

#Board object which stores locations and pieces
class Board

  attr_reader :locations
  #Creates a new instance of board containing empty locations
  def initialize
    @locations = []
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
    @locations.push([l00, nil, nil, l03, nil, nil, l06])
    @locations.push([nil, l11, nil, l13, nil, l15, nil])
    @locations.push([nil, nil, l22, l23, l24, nil, nil])
    @locations.push([l30, l31, l32, nil, l34, l35, l36])
    @locations.push([nil, nil, l42, l43, l44, nil, nil])
    @locations.push([nil, l51, nil, l53, nil, l55, nil])
    @locations.push([l60, nil, nil, l63, nil, nil, l66])
  end

  #Return location at specified coordinates or nil if invalid coordinates
  def selectLocation(x, y)
    if x.instance_of?(Integer) && y.instance_of?(Integer)
      if x.between?(0,6) && y.between?(0,6)
        return @locations[x][y]
      end
    end
    return nil
  end

  #Return piece at specified coordinates or nil if invalid coordinates (piece is removed from board)
  def selectPiece(x, y)
    if x.instance_of?(Integer) && y.instance_of?(Integer)
      if x.between?(0,6) && y.between?(0,6)
        return @locations[x][y].piece
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
      if x.between?(0,6) && y.between?(0,6)
        return @locations[x][y].isEmpty
      end
    end
  end

  #Checks if piece is adjacent to location
  def isAdjacent(piece, location)
    if piece.instance_of?(Piece) && location.instance_of?(Location) && piece.location != nil
      x1 = piece.location.coordinates[0]
      y1 = piece.location.coordinates[1]
      x2 = location.coordinates[0]
      y2 = location.coordinates[1]
      adjacent = false
      if ((x1.between?(0,6)) && (y1.between?(0,6)) &&
         (x2.between?(0,6)) && (y2.between?(0,6)))
        #concatenate coordinates into strings for case statement
        pieceCoordinates = "#{x1}#{y1}"
        locationCoordinates = "#{x2}#{y2}"
        case pieceCoordinates
        when "00"
          case locationCoordinates
          when "30", "03"
            adjacent = true
          else
          end
        when "03"
          case locationCoordinates
          when "00", "13", "06"
            adjacent = true
          else
          end
        when "06"
          case locationCoordinates
          when "03", "36"
            adjacent = true
          else
          end
        when "11"
          case locationCoordinates
          when "13", "31"
            adjacent = true
          else
          end
        when "13"
          case locationCoordinates
          when "03", "11", "15", "23"
            adjacent = true
          else
          end
        when "15"
          case locationCoordinates
          when "13", "35"
            adjacent = true
          else
          end
        when "22"
          case locationCoordinates
          when "23", "32"
            adjacent = true
          else
          end
        when "23"
          case locationCoordinates
          when "13", "22", "24"
            adjacent = true
          else
          end
        when "24"
          case locationCoordinates
          when "23", "34"
            adjacent = true
          else
          end
        when "30"
          case locationCoordinates
          when "00", "31", "60"
            adjacent = true
          else
          end
        when "31"
          case locationCoordinates
          when "30", "11", "32", "51"
            adjacent = true
          else
          end
        when "32"
          case locationCoordinates
          when "22", "31", "42"
            adjacent = true
          else
          end
        when "34"
          case locationCoordinates
          when "24", "35", "44"
            adjacent = true
          else
          end
        when "35"
          case locationCoordinates
          when "15", "34", "36", "55"
            adjacent = true
          else
          end
        when "36"
          case locationCoordinates
          when "06", "35", "66"
            adjacent = true
          else
          end
        when "42"
          case locationCoordinates
          when "32", "43"
            adjacent = true
          else
          end
        when "43"
          case locationCoordinates
          when "42", "43", "53"
            adjacent = true
          else
          end
        when "44"
          case locationCoordinates
          when "34", "43"
            adjacent = true
          else
          end
        when "51"
          case locationCoordinates
          when "31", "53"
            adjacent = true
          else
          end
        when "53"
          case locationCoordinates
          when "43", "55", "63", "51"
            adjacent = true
          else
          end
        when "55"
          case locationCoordinates
          when "35", "53"
            adjacent = true
          else
          end
        when "60"
          case locationCoordinates
          when "03", "63"
            adjacent = true
          else
          end
        when "63"
          case locationCoordinates
          when "60", "53", "66"
            adjacent = true
          else
          end
        when "66"
          case locationCoordinates
          when "36", "63"
            adjacent = true
          else
          end
        else
        end
      end
    end
    adjacent
  end
end
