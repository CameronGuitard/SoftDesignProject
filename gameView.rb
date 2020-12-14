require 'colorize'

class GameView

    def refreshBoard(board, millPieces)
        board.locations.each {|row|
            printableRow = ""
            puts " look under"
            puts row
            puts " look up"
            row.each{|location|
                if location == nil || location.isEmpty()
                    printableRow += " "
                else
                    isMill = false
                    millPieces.each {|millPiece|
                        if millPiece.location == location
                            isMill = true
                            break
                        end
                    }
                    if isMill
                        printableRow += "o".yellow
                    elsif location != nil && location.piece.colour() == "#0000FF"
                        printableRow += "o".blue
                    else
                        printableRow += "o".red
                    end
                end
            }
            puts row
        }
    end

    def refreshTurnIndicator(player)
        if (player.assignColour == "#0000FF")
            puts "Player Turn: " + "o".blue
        else
            puts "Player Trun: " + "o".red
        end
    end

    def refreshUnplayedPieces(player)
        if (player.assignColour == "#0000FF")
            puts "Unplayed Pieces: " + "o".blue + " " + player.numUnplayedPieces().to_s

        else
            puts "Unplayed Pieces: " + "o".red + " " + player.numUnplayedPieces().to_s
        end
        
    end

    def highlightPieces(pieces, colour)

    end

    def highlightLocations(locations, colour)

    end
end
