require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        input.grid.drawFloor
        puts input.grid.to_s
        
        count = 0
        while input.grid.addSand({500,0}, :two) == :moreSand
            count +=1
        end
        puts input.grid.to_s
        
        (count+1).to_s
    end
end