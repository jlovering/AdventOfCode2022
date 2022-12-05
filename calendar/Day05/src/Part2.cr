require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def do_move(from, to, n)
        crane = [] of Char
        n.times { crane << @input.stacks[from].pop }
        n.times { @input.stacks[to] << crane.pop }
    end

    def run()
        @input.moves.each do |m|
            do_move(m[1], m[2], m[0])
        end
        @input.stacks.keys.sort.map { |k| @input.stacks[k].last }.compact.join
    end
end