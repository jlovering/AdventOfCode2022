class Input
    property input = [] of Array(Int32)

    def initialize(filename : String)
        File.each_line(filename) do |line|
            @input << line.chars.map(&.to_i)
        end
    end
end