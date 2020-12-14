class Coin 
    
    attr_accessor :sideUp

    def flip
        if (rand(0...10) % 2) == 0 
            @sideUp = "Heads"
         else 
            @sideUp = "Tails"
         end
    end

    def display
        return @sideUp
    end

    def initialize
        @sideUp = nil
    end

end