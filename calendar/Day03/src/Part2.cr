require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def priorities(c : Char)
        if c.uppercase?
            c - 'A' + 27
        else 
            c - 'a' + 1
        end
    end

    def run()
        c = @input.input.in_groups_of(3).map do |g|
            e1, e2, e3 = g.compact.map(&.chars.to_set)
            u = e1 & e2 & e3
            u.to_a[0]
        end
        c.map { |i| priorities(i) }.sum.to_s
    end
end