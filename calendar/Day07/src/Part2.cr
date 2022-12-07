require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        unused_space = 70000000 - input.dirs.subsize
        required_space = 30000000 - unused_space
        s = input.dirs.get_subsizes
        s.select { |v| v >= required_space }.sort.first.to_s
    end
end