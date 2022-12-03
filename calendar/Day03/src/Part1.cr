require "./Input.cr"

class Part1
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
        c = @input.input.map do |l|
            c1, c2 = l[...l.size//2].chars.to_set, l[l.size//2..].chars.to_set
            (c1 & c2).to_a[0]
        end
        c.map { |i| priorities(i) }.sum.to_s
    end
end