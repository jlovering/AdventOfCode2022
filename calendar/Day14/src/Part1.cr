require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        puts input.grid.to_s
        count = 0
        while input.grid.addSand({500,0}) == :moreSand
            count +=1
        end
        puts input.grid.to_s
        count.to_s
    end
end