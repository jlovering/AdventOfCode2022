require "./Input.cr"

DEBUG = false

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        input.roboRules.map do |rRs|
            p Solver.new(rRs).solveMinute([0,0,0,0], 24, [0,0,0,1])
        end.map_with_index(1) do |g, i|
            g * i
        end.sum.to_s
    end
end