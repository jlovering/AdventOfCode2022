require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        @input.input.map do |l|
            rs = l.split(/,/).map do |p| 
                b, e = p.split(/-/).map &.to_i
                Range.new(b,e).to_set
            end
            r1, r2 = rs.compact
            if (r1 & r2).size == 0
                0
            else
                1
            end
        end.sum.to_s
    end
end