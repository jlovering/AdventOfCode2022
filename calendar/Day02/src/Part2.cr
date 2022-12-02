require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def translate
        { 
            "A" => :rock,
            "B" => :paper,
            "C" => :sissors,
            "X" => :lose,
            "Y" => :draw,
            "Z" => :win
        }
    end

    def scorethrow
        {
            :rock => 1,
            :paper => 2,
            :sissors => 3
        }
    end

    def findthrow(a, o)
        case o
        when :lose
            case a
            when :rock
                :sissors
            when :sissors
                :paper
            when :paper
                :rock
            end
        when :win
            case a
            when :rock
                :paper
            when :sissors
                :rock
            when :paper
                :sissors
            end
        else
            a
        end
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

    def run()
        @input.input.map do |l| 
            a, b = l.split(/ /).map { |v| translate[v] }
            th = findthrow(a,b)
            scorethrow[th] + win(th,a)
        end.sum.to_s
    end
end