require "./Input.cr"

class Part1
    property input : Input
    getter cycles : Int32
    getter x : Int32
    getter nextTr : Int32
    getter acc : Int32

    def initialize(file : String)
        @input = Input.new(file)
        @cycles = 0
        @x = 1
        @acc = 0
        @nextTr = 20
    end

    def accum
        if cycles >= nextTr
            # p "#{nextTr} #{cycles} #{x}"
            @acc += x * nextTr
            @nextTr += 40
        end
    end

    def run()
        @cycles = 0
        @x = 1
        @acc = 0
        @nextTr = 20
        input.input.each do |i|
            case i
            when /noop/
                @cycles += 1
                accum
            when /addx ([-0-9]+)/
                @cycles += 1
                accum
                @cycles += 1
                accum
                @x += $~[1].to_i
            end
        end
        acc.to_s
    end
end