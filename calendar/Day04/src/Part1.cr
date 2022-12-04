require "./Input.cr"

class Part1
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
            us = r1 | r2
            if r1.size >= r2.size && r1 == us
                1
            elsif r2.size >= r1.size && r2 == us
                1
            else
                0
            end
        end.sum.to_s
    end
end