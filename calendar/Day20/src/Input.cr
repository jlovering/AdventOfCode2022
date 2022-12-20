class Input
    property numbs = [] of Int32

    def initialize(filename : String)
        File.each_line(filename) do |line|
            @numbs << line.to_i
        end
    end
end