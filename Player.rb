require_relative "Piece.rb"
#
#   This class represents a player for the game
#
class Player
    attr_writer :gameBoard
    attr_writer :gameController
    attr_accessor :isActive, :name
    attr_reader :playedPieces, :unplayedPieces
    #This initializing the player with a name, a gameBoard instance and a gameController instance 
    def initialize(name)
        @name = name
        @unplayedPieces = []
        @playedPieces = []
        @isActive = false
        @colour = nil
        @gameBoard = nil
        @gameController = nil
    end

    #This function starts the the players turn and handles all its input and calling other classes
    def turnStart()
        @isActive = true
        currentPiece = nil
        if numUnplayedPieces > 0 #Workflow for when the player is placing pieces on the board
            currentPiece = @unplayedPieces[0]
            validMove = false
            while validMove == false
                puts "Please select the location to place a piece with the following format 'x y', or type 'f' to forfeit"
                input = gets.chomp
                if input == 'f'
                    @gameController.forfeit(self)
                    return
                end
                coordinates = input.split(' ')
                location = @gameBoard.selectLocation(coordinates[0].to_i,coordinates[1].to_i)
                validMove = @gameController.validMove(currentPiece,location)
                if validMove
                    @gameBoard.movePiece(currentPiece,location)
                    @unplayedPieces.shift()
                    @playedPieces.push(currentPiece)
                end
            end
        else #Workflow for when the player is moving pieces around the board
            validMove = false
            while validMove == false
                puts "Please select the piece to move with the following format 'x y', or type 'f' to forfeit"
                input = gets.chomp
                if input == 'f'
                    @gameController.forfeit(self)
                    return
                end
                coordinates= input.split(' ')
                selectedPiece = @gameBoard.selectPiece(coordinates[0].to_i,coordinates[1].to_i)
                puts "Please select the location to move the piece to with the following format 'x y', or type 'f' to forfeit"
                input = gets.chomp
                if input == 'f'
                    @gameController.forfeit(self)
                    return
                end
                coordinates= input.split(' ')
                selectedLocation = @gameBoard.selectLocation(coordinates[0].to_i,coordinates[1].to_i)
                validMove = @gameController.validMove(selectedPiece,selectedLocation)
                if validMove
                    @gameBoard.movePiece(selectedPiece,selectedLocation)
                else
                    puts "Invalid move."
                end
            end
        end

        isMill = @gameController.checkMill(currentPiece)
        if isMill #Workflow for when a player creates mill
            puts "Congrats on the mill"
            validRemoval = false
            while validRemoval == false
                puts "Please select an opponents piece to remove with the following format 'x y', or type 'f' to forfeit"
                input = gets.chomp
                if input == 'f'
                    @gameController.forfeit(self)
                    return
                end
                coordinates = input.split(' ')
                milledPiece = @gameBoard.selectPiece(coordinates[0].to_i,coordinates[1].to_i)
                validRemoval = @gameController.validRemoval(milledPiece)
                if validRemoval
                    @gameBoard.removePiece(milledPiece)
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
            @unplayedPieces.push(Piece.new(colour))
        end
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

    def clearPieces()
        @unplayedPieces = []
        @playedPieces = []
    end

    def updatePlayedPieces()
        index = 0
        while index <  @playedPieces.length()
            if @playedPieces[index].location == nil
                @playedPieces.delete_at(index)
            else
                index += 1
            end
        end
    end
end
