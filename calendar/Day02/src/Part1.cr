require "./Input.cr"

class Part1
    property input : Input

    def translate
        { 
            "A" => :rock,
            "B" => :paper,
            "C" => :sissors,
            "X" => :rock,
            "Y" => :paper,
            "Z" => :sissors
        }
    end

    def scorethrow
        {
            :rock => 1,
            :paper => 2,
            :sissors => 3
        }
    end

    def win(a, b)
        case [a, b]
        when [:rock, :sissors], [:sissors, :paper], [:paper, :rock]
            6
        when [:rock, :rock], [:paper, :paper], [:sissors, :sissors]
            3
        else
            0
        end
    end

    def initialize(file : String)
        @input = Input.new(file)
        
    end

    def run()
        @input.input.map do |l| 
            a, b = l.split(/ /).map { |v| translate[v] }
            scorethrow[b] + win(b,a)
        end.sum.to_s
    end
end