require "./Input.cr"

class Part2
    property input : Input
    getter cycles : Int32
    getter x : Int32
    getter crt_row : Int32
    getter crtImage : Array(Array(Char))

    def initialize(file : String)
        @input = Input.new(file)
        @cycles = 0
        @x = 1
        @crt_row = 0
        @crtImage = Array(Array(Char)).new()
    end

    def splat
        cr
        if (cycles) >= (x-1) && (cycles) <= (x+1)
            crtImage[crt_row][cycles] = '#'
        end
    end

    def cr
        if cycles >= 40
            @cycles = 0
            @crt_row += 1
            crtImage << Array(Char).new(40, '.')
        end
    end

    def run()
        @cycles = 0
        @x = 1
        @crtImage << Array(Char).new(40, '.')
        input.input.each do |i|
            case i
            when /noop/
                splat
                @cycles += 1
            when /addx ([-0-9]+)/
                splat
                @cycles += 1
                splat
                @cycles += 1
                @x += $~[1].to_i
            end
        end
        crtImage.map(&.join()).join('\n')
    end
end