class Input
    property input = [] of Int32

    def initialize(filename : String)
        File.each_line(filename) do |line|
            @input << line.to_i
        end
    end
end