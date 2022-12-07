require "./Input.cr"
require "./ntree.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        s = input.dirs.get_subsizes
        s.select { |v| v <= 100000 }.sum.to_s
    end
end