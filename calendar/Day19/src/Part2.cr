require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        input.roboRules.map_with_index do |rRs, i|
            if i < 3
                p Solver.new(rRs).solveMinute([0,0,0,0], 32, [0,0,0,1])
            end
        end.compact.reduce(1) { |acc, v| acc*v }.to_s
    end
end