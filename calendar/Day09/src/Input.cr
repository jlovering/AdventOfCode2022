class Input
    property actions = Array(Tuple(Char,Int32)).new()

    def initialize(filename : String)
        File.each_line(filename) do |line|
            md = line.match(/(U|D|L|R)+ ([0-9]+)/)
            if (m = md)
                @actions << {m[1].chars[0], m[2].to_i}
            end
        end
    end
end