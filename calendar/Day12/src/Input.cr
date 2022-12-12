alias Point = Tuple(Int32, Int32) 

class Input
    getter rawinput = [] of Array(Char)
    getter heightMap = [] of Array(Int32)
    getter startP = Array(Point).new()
    getter endP = Point.new(-1, -1)

    def initialize(filename : String)
        File.each_line(filename) do |line|
            @rawinput << line.chars
            @heightMap << Array(Int32).new(line.chars.size, -1)
        end
        @rawinput.each_with_index do |r, j|
            r.each_with_index do |v, i|
                case v
                when 'S', 'a'
                    @startP << {i, j}
                    @heightMap[j][i] = 0
                when 'E'
                    @endP = {i, j}
                    @heightMap[j][i] = 26
                else
                    @heightMap[j][i] = v - 'a'
                end
            end
        end
    end
end