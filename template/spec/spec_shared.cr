class DaySpec
    getter dayPath : Path
    getter dayShortName : String

    def initialize
        @dayPath = Path.new(__DIR__, "../").normalize
        @dayShortName = dayPath.basename
    end
end