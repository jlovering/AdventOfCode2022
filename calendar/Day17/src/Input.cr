class Input
    property moves = [] of Char
    @nextMove : Iterator(Char)

    def initialize(filename : String)
        @moves = File.read(filename).chomp.chars
        @nextMove = moves.each
        @idx = 0
    end

    def movesReset
        @idx = 0
        @nextMove = moves.each
    end

    def nextMove
        @idx += 1
        {@nextMove.next, @idx}
    end
end