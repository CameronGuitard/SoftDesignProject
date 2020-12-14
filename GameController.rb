require_relative "board"
require_relative "player"
require_relative "location"
require_relative "piece"
require_relative "coin"
require_relative "gameView"

class GameController 
    # each player has a bag and a cup
    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @board = Board.new() # creates new Board
        @coin = Coin.new() # new coin
        @view = GameView.new() # might not need this

        @player1.gameBoard = @board
        @player2.gameBoard = @board
        @player1.gameController = self
        @player2.gameController = self
    end

    #public method
    #Resets the game, returns true if successfull
    def reset()

        @board.locations.each do |row|
            row.each do |location|
                
                # removes all pieces from the board.
                location.removePiece()                                        
            end
        end

        # player 1, remove all pieces
        for piece in @player1.unplayedPieces
            piece = nil
        end

        # player2, remove all pieces
        for piece in @player2.unplayedPieces
            piece = nil         
        end

        # calls start game
        startGame(@player1, @player2)

    end
    
    #public
    # checks the board for a new mil
    # returns true if there is a new mil
    # false if there is not
    def checkMill(piece)

        #  each piece can be in a verticle and horizontal mill.
        #  given a coordinate (letter and number) a verticle mill can be determined by searching the array for every number value that has the letter coordinate.
            # e.g if (d,2) is passed in, then to see if there is a vericle mill (d,1), (d,2) and (d,3) will be found in the array of locations
            # call selectPiece() on each space, if any spaces are empty there is no mill
            # call  piece.colour, if all 3 pieces are the same colour of the passed piece, then it is a Mill, Return True
        # check for a horizontal mill. horizontal mill can be determined by searching the array for every coordinate that shares the number.
            # e.g if (G,1) is passed in, then to see if there is a vericle mill (G,1), (D,1) and (A,1) will be found in the array of locations
            # call selectPiece() on each space, if any spaces are empty there is no mill
            # call  piece.colour, if all 3 pieces are the same colour of the passed piece, then it is a Mill, Return True
        # there will be a special consideration for any piece containing 4. 

        # location of piece
        puts "A"
        puts piece.location
        puts "B"
        puts piece.location.coordinates

        x_coordinate = piece.location.coordinates[0]
        y_coordinate = piece.location.coordinates[1]

        hMill = false
        vMill = false

        verticalMill = []
        horizontalMill = []


        
        #horisontal
        @board.locations.each do |row|
            row.each do |location|
                
                if  location != nil && !location.isEmpty() && location.coordinates[0] == x_coordinate
                    if x_coordinate == 3 && y_coordinate <= 3
                        # only add piece if it is in row 3 column 0-3. 
                        if location.coordinates[1] <= 3
                            horizontalMill.push(location.piece)
                        end
                    elsif x_coordinate == 3 && y_coordinate >= 4
                        # only add piece if it is in row 3 column 4-6. 
                        if location.coordinates[1] >= 4
                            horizontalMill.push(location.piece)
                        end
                    else
                        # will add the piece if its not in the strange row
                        horizontalMill.push(location.piece)
                    end
                end                                 
            end
        end

        #verticle
        @board.locations.each do |row|
            row.each do |location|           
                if location != nil && !location.isEmpty() && location.coordinates[1] == y_coordinate
                    verticalMill.push(location.piece)
                end
            end
        end


        if verticalMill.length > 3
            puts "I made an oopsy this should not happen. test this later im to lazy now"
        elsif verticalMill.length == 3
            # check for mill
            # assume there is a mill
            vMill = true
            for millPiece in verticalMill
                if !(millPiece.colour() == piece.colour())
                    vMill = false
                end
            end
        else
            # there is no vertical mill
            vMill = false
        end


        if horizontalMill.length > 3
            puts "Should not happen if it does i made a mistake"   
        elsif horizontalMill.length == 3
            # check for mill
            # assume there is a mill
            hMill = true
            for millPiece in horizontalMill
                if !(millPiece.colour() == piece.colour())
                    hMill = false
                end
            end
        else
            # there is no vertical mill
            hMill = false
        end
        
        if vMill || hMill
            return true
        else
            return false
        end
    end

    # public method
    # ensures that a move a player is attempting is valid.
    # returns true if valid
    # false if not
    def validMove(piece, newLocation)
        # piece can move to any empty adjacent space.
        # might need to account for placing pieces. can be counted as a fly move i guess 

        if newLocation == nil
            return false
        end

        # check if its a fly move. 
        if @player1.isActive
           if @player1.numPlayedPieces < 3
                fly = true 
           else
                fly = false
           end
        else
            if @player2.numPlayedPieces < 3
                fly = true 
           else
                fly = false
           end
        end


        #checks if space is empty:
        if newLocation.isEmpty()

            # check if its a fly move
            if fly
                # if its a fly and the target location is empty its allowed. 
                return true
            elsif piece.location == nil
                return true
            else
                # should return true if the move is valid.
                bool = @board.isAdjacent(piece,newLocation)
                if bool
                    return true
                else
                    return false
                end
            end
        else
            # should the space is not empty, the move is invalid
            puts "Cannot move a piece to an occupied space."
            return false
        end

    end
    
    # public method
    # ensures that the capture a player is attempting is valid.
    # returns true if valid
    # false if not
    def validRemoval(targetPiece)

        if targetPiece == nil
            puts "nil"
            return false
        end
        ## check if piece is in a mill    
        if !checkMill(targetPiece)
            # not in mill it is a valid capture
            return true
        else
            # it is in a mill, check if it is a valid removal
            if targetPiece.colour == @player1.assignedColour()
                #piece is player1's
                
                for piece in @player1.playedPieces
                    if !checkMill(piece)
                        # if a piece is not in a mill
                        puts "Cannot remove a piece from a Mill. There is annother valid target."
                        return false
                    end
                end

            else
                #piece is player 2's
                for piece in @player2.playedPieces
                    if !checkMill(piece)
                        # if a piece is not in a mill
                        puts "Cannot remove a piece from a Mill. There is annother valid target."
                        return false
                    end
                end
            end

        end
        
        #if it exits from above then it will be a valid removal. 
        return true

    end

    # public method
    # starts a game
    # P1 is player who started game
    # P2 is player who joined
    def startGame(player1, player2)

        puts " Do you want heads(h) or tails(t)?"
        answer = gets
        answer = answer.chomp
        first = false

        # flips the coin
        @coin.flip

        # player1 calls what face they want
        if answer == 't'
            if @coin.display == 'Heads'
                first = false
                
            else
                first = true
            end
        elsif answer == 'h'
            if @coin.display == 'Heads'
                first = true
            else
                first = false
            end
        else
            puts " fix later"
        end

        # assigns colours baised on who goes first
        if first
            player1.givePieces("#FF0000")
            player2.givePieces("#0000FF")
        else
            player1.givePieces("#0000FF")
            player2.givePieces("#FF0000")
        end

        if first
            puts "Congrats Player 1 you are going first"
            @view.refreshBoard(@board, [])
            player1.turnStart()
        else
            puts "Player 1, You are going second"
            @view.refreshBoard(@board, [])
            player2.turnStart()
        end
        
        while !checkWin() do

            if player1.isActive
                # player 1 is active
                @player1.turnEnd()
                @view.refreshTurnIndicator(@player1)
                @view.refreshBoard(@board, [])
                player2.turnStart()
             else
                # player 2 is active
                @player2.turnEnd()
                @view.refreshTurnIndicator(@player2)
                @view.refreshBoard(@board, [])
                player1.turnStart()
             end

        end

        # ask if user's want to reset.
        puts " Do you want to reset and play annother game? Please enter Y or N."
        answer = gets
        answer = answer.chomp

        # handle input
        if answer == 'Y' || answer == 'y'
            reset()
        elsif answer == 'N' || answer == 'n'
            puts "Goodbye I hope you had fun playing the game!"
        else
            puts " Invalid input detected. The game will be reset"
            reset()        
        end    
    end

    # public method
    # checks board for a winner
    # if there is a winner then the game is ended
    def checkWin()
        # bool vars to check valid moves 
        player1Valid = false
        player2Valid = false

        if @player1.numPlayedPieces <=2 && @player1.numUnplayedPieces == 0 
            puts "Player 2 has won the game!"
            return true
        elsif @player2.numPlayedPieces <=2 && @player2.numUnplayedPieces == 0 
            puts "Player 1 has won the game!"
            return true
        else
            # both players have more then 2 pieces on the bord.
            # check if players have valid moves left.
            if @player1.numUnplayedPieces >= 0 
                # No winner there is a valid move for player1.
                puts "Player 1 has valid moves"
                return false
            elsif @player2.numUnplayedPieces >= 0 
                puts "Player 2 has valid moves"
                return false
            else
                # check if any moves are possible.

                # player 1
                # until true, loop through played pieces, for each location call validMove(). there is no (get adjacent function so this is clunky sorry)
                for piece in @player1.playedPieces
                    
                    @board.locations.each do |row|
                        row.each do |location|
                            
                            # validMove will return true if it is valid. 
                            if validMove(piece, location)
                                player1Valid = true
                            end 
                            break if player1Valid                           
                        end
                        break if player1Valid 
                    end
                    break if player1Valid 
                end

                #player2
                for piece in @player2.playedPieces
                    
                    @board.locations.each do |row|
                        row.each do |location|
                            
                            # validMove will return true if it is valid. 
                            if validMove(piece, location)
                                player2Valid = true
                            end 
                            break if player2Valid                            
                        end
                        break if player2Valid   
                    end
                    break if player2Valid   
                end
                

                if !player1Valid && !player2Valid   
                    puts "Both Player's have no moves. The game is a draw"
                    return true
                
                elsif !player1Valid
                    # player1 has no remaining moves
                    puts  @player1.name +" has no valid moves,"  + @player2.name + " wins!"
                    return true

                
                elsif !player2Valid
                    # player1 has no rem
                    puts  @player2.name +" has no valid moves,"  + @player1.name + " wins!"
                    return true
                    
                else
                    puts " both players have valid moves left. The game is not over."
                    return false
                end
            end
        end

    end

    # public method
    # called by a player
    # Msg is sent to other player, if that player accepts the game is ended.
    def forefit(player)

        puts  player.name +" Please accept(Y) or reject(N) your opponents surrender."
        answer = gets
        answer = answer.chomp

        # handle input
        if answer == 'Y' || answer == 'y'
            # player1 calls what face they want
            puts  player.name +" Has won the game!"
            # reset()
            # force end the game?
            exit
            
        elsif answer == 'N' || answer == 'n'
            # player1 calls what face they want
            puts  player.name +" Has rejected surrender. The game continues!"

        else
            puts  player.name +" Has suplied invalid input. The game continues!" 
        end

    end
end