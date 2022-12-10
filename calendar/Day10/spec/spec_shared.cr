class DaySpec
    getter dayPath : Path
    getter dayShortName : String
    getter dayNumber : Int32
    getter enableSubmit : Bool

    def initialize
        @dayPath = Path.new(__DIR__, "../").normalize
        @dayShortName = dayPath.basename
        if (md = dayShortName.match(/Day([0-9]{2})/))
            @dayNumber = md[1].to_i
        else
            @dayNumber = 1
        end
        @enableSubmit = false
{% if flag?(:submit) %}
        @enableSubmit = true
{% end %}
    end
end