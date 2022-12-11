class Input
    getter rawMonkey : Array(String)

    def initialize(filename : String)
        @rawMonkey = File.read(filename).split("\n\n")
    end
end