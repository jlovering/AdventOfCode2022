require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def do_move(from, to)
        @input.stacks[to] << @input.stacks[from].pop
    end

    def run()
        @input.moves.each do |m|
            m[0].times { do_move(m[1], m[2]) }
        end
        @input.stacks.keys.sort.map { |k| @input.stacks[k].last }.compact.join
    end
end