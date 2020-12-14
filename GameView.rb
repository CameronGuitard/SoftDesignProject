require 'colorize'

class GameView

    def refreshBoard(board, millPieces)
        x = 0
        puts "   0  1  2  3  4  5  6 Y"
        board.locations.each {|row|
            printableRow = x.to_s + " "

            y = 0
            row.each{|location|
                if location == nil || location.isEmpty()
                    if x == 0 || x == 6
                        if y == 1 || y == 2 || y == 4 || y == 5
                            printableRow += "———"
                        elsif y == 0 || y == 3 || y == 6
                            printableRow += " • "
                        else
                            printableRow += "   "
                        end
                    end

                    if x == 1 || x == 5
                        if y == 0 || y == 6
                            printableRow += " | "
                        elsif y == 2 || y == 4
                            printableRow += "———"
                        elsif y == 1 || y == 5 || y == 3
                            printableRow += " • "
                        else
                            printableRow += "   "
                        end
                    end

                    if x == 2 || x == 4
                        if y == 0 || y == 6 ||y == 1 || y == 5
                            printableRow += " | "
                        elsif y == 2 || y == 3 || y == 4
                            printableRow += " • "
                        end
                    end

                    if x == 3
                        if y == 3
                            printableRow += "   "
                        else
                            printableRow += " • "
                        end
                    end
                    
                else
                    # isMill = false
                    # millPieces.each {|millPiece|
                    #     if millPiece.location == location
                    #         isMill = true
                    #         break
                    #     end
                    # }
                    # if isMill
                    #     printableRow += "o".yellow
                    if location != nil && location.piece.colour() == "#0000FF"
                        printableRow += " o ".blue
                    else
                        printableRow += " o ".red
                    end
                end
                y += 1
            }
            puts printableRow
            x += 1
        }

        puts "X"
    end

    def refreshTurnIndicator(player)
        if (player.assignedColour() == "#0000FF")
            puts "Player Turn: " + "o".blue
        else
            puts "Player Trun: " + "o".red
        end
    end

    def refreshUnplayedPieces(player)
        if (player.assignedColour() == "#0000FF")
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
