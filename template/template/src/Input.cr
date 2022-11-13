class Input
    property input = [] of String

    def initialize(filename : String)
        File.each_line(filename) do |line|
            @input << line
        end
    end
end