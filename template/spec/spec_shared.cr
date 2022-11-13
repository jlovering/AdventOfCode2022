class DaySpec
    getter dayPath : Path
    getter dayShortName : String
    getter dayNumber : Int32

    def initialize
        @dayPath = Path.new(__DIR__, "../").normalize
        @dayShortName = dayPath.basename
        if (md = dayShortName.match(/Day([0-9]{2})/))
            @dayNumber = md[0].to_i
        else
            @dayNumber = 1
        end
    end
end