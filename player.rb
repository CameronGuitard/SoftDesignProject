require "./Piece.rb"
#
#   This class represents a player for the game
#
class Player
    #This initializing the player with a name, a gameboard instance and a gameController instance 
    def initialize(name,gameboard,gameController)
        @name = name
        @unplayedPieces = []
        @playedPieces = []
        @isActive = false
        @gameboard = gameboard
        @gameController = gameController
    end

    #This function starts the the players turn and handles all its input and calling other classes
    def turnStart()
        @isActive = true
        currentPiece = nil
        if numUnplayedPieces > 0 #Workflow for when the player is placing pieces on the board
            currentPiece = @unplayedPieces[0]
            validMove = false
            while validMove == false
                puts "Please select the location to place a piece with the following format 'x y'"
                input = gets.chomp
                coordinates = input.split(' ')
                location = @gameboard.selectLocation(coordinates[0],coordinates[1])
                validMove = @gameController.validMove(currentPiece,location)
                if validMove
                    @gameboard.movePiece(currentPiece,location)
                    @unplayedPieces.shift()
            end
        else #Workflow for when the player is moving pieces around the board
            validMove = false
            while validMove == false
                puts "Please select the piece to move with the following format 'x y'"
                input = gets.chomp
                coordinates.split(' ')
                selectedPiece = @gameboard.selectPiece(coordinates[0],coordinates[1])
                puts "Please select the location to move the piece to with the following format 'x y'"
                input = gets.chomp
                coordinates.split(' ')
                selectedLocation = @gameboard.selectPiece(coordinates[0],coordinates[1])
                validMove = @gameController.validMove(selectedPiece,selectedLocation)
                if validMove
                    @gameboard.movePiece(selectedPiece,selectedLocation)
            end
        end

        isMill = @gameController.checkMill(currentPiece)
        if isMill #Workflow for when a player creates mill
            puts "Congrats on the mill"
            validRemoval = false
            while validRemoval == false
                puts "Please select an opponents piece to remove with the following format 'x y'"
                input = gets.chomp
                coordinates = input.split(' ')
                milledPiece = @gameboard.selectPiece(coordinates[0],coordinates[1])
                validRemoval = @gameController.validRemoval(milledPiece)
                if validMill
                    @gameboard.removePiece(milledPiece)
                end
            end
        end
    end

    #This ends this players turn
    def turnEnd()
        @isActive = false
    end

    #This gives the user 12 pieces of the specified colour
    def givePieces(colour)
        for i in 1..12 do
            @unplayedPieces.push(colour)
    end

    #This returns the number of played piece 
    def numPlayedPieces()
        return @playedPieces.length()
    end

    #This returns the number of unplayed pieces
    def numUnplayedPieces()
        return @unplayedPieces.length()
    end

    #This returns the players colour
    def assignedColour()
        return @colour
    end

    #This sets the players colour
    def setColour(colour)#***********
        @colour = colour
    end
end