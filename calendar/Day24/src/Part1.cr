require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        g = Grid.new(@input.input)
        Solver.cross({1,0}, g.homeP, g).to_s
    end
end