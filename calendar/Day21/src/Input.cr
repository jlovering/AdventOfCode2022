def performOp(a : Int64, b : Int64, op : String): Int64
    case op
    when "+"
        a + b
    when "-"
        a - b
    when "*"
        a * b
    when "/"
        a // b
    else
        raise "Bad Op"
    end
end

def inverseOp(lhs : Int64, b : Int64, op : String, first): Int64
    case op
    when "+"
        lhs - b
    when "-"
        case first
        when :p1
            b - lhs
        when :p2
            lhs + b
        else
            raise "bad position"
        end
    when "*"
        lhs // b
    when "/"
        lhs * b
    else
        raise "Bad Op"
    end
end

alias MonkeyProblem = Tuple(String, String, String)

class Input
    property mnk = Hash(String, Int64 | MonkeyProblem).new()
    getter maxN = 0

    def initialize(filename : String)
        File.each_line(filename) do |line|
            case line
            when /(\w{4}): (\w{4}) ([\+\-\*\/]{1}) (\w{4})/
                _, m, m1, op, m2 = $~
                mnk[m] = {m1, m2, op}
            when /^(\w{4}): (\d+)$/
                _, m, v = $~
                mnk[m] = v.to_i
                @maxN = [v.to_i, @maxN].max
            else
                raise "No match"
            end
        end
    end
end