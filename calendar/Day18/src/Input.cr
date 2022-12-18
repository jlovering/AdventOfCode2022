alias Point = Tuple(Int32, Int32, Int32)

class Input
    property cubes = Set(Point).new()

    def initialize(filename : String)
        File.each_line(filename) do |line|
            x,y,z = line.split(",").map(&.to_i)
            @cubes.add(Point.new(x,y,z))
        end
    end
end