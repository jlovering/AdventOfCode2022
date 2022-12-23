alias Point = Tuple(Int32, Int32)

class Input
    property input = [] of String
    property elves = Set(Point).new()

    def initialize(filename : String)
        f = File.read(filename)
        f.split("\n").each_with_index do |line, y|
            @input << line
            line.chars.each_with_index do |c, x|
                if c == '#'
                    @elves.add({x,y})
                end
            end
        end
    end
end