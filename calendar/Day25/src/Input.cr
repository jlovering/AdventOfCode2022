class SNAFU
    getter snafu : Array(Char)
    getter decimal : Int64

    def initialize
        @snafu = [] of Char
        @decimal = 0
    end

    def initialize(str : String)
        @snafu = str.chars
        @decimal = @snafu.reverse.map_with_index do |n, i|
            case n
            when '-'
                Int64.new(-1)
            when '='
                Int64.new(-2)
            when .number?
                n.to_i64
            else
                raise "Bad char in SNAFU #{n}"
            end.* Int64.new(5)**i
        end.sum
    end

    def initialize(dec : Int64)
        @snafu = [] of Char
        @decimal = dec
        b5dig = dec.digits(5)
        extra = ""
        @snafu = (b5dig.map_with_index do |d, i|
            case d
            when 3
                if i+1 < b5dig.size
                    b5dig[i+1] += 1
                else
                    extra = "1"
                end
                "="
            when 4
                if i+1 < b5dig.size
                    b5dig[i+1] += 1
                else
                    extra = "1"
                end
                "-"
            when 5
                if i+1 < b5dig.size
                    b5dig[i+1] += 1
                else
                    extra = "1"
                end
                "0"
            else
                d.to_s
            end
        end.join + extra).chars.reverse
    end
end

class Input
    property input = [] of String

    def initialize(filename : String)
        File.each_line(filename) do |line|
            @input << line
        end
    end
end