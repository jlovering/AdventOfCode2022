require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        g = Grid.new(@input.input)
        t1 = Solver.cross({1,0}, g.homeP, g)
        t2 = Solver.cross(g.homeP, {1,0}, g, false)
        t3 = Solver.cross({1,0}, g.homeP, g, false)
        (t1+t2+t3).to_s
    end
end