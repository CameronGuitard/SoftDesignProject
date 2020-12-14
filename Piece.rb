class Piece
    attr_accessor :colour
    attr_accessor :location

    def colour
        return @colour
    end

    def location
        return @location
    end

    def initialize(colour)
        @colour = colour
    end

end