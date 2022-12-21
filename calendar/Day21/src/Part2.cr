require "./Input.cr"

DEBUG = false

class Solver
    def initialize(@mnk : Hash(String, Int64 | MonkeyProblem))
    end

    def solve(input=nil)
        solveQueue = Array(Tuple(String, MonkeyProblem)).new()

        if i = input
            @mnk["humn"] = i
        else
            @mnk["humn"] = {"humn", "humn", "no"}
        end

        @mnk.each do |k, v|
            if v.is_a?(MonkeyProblem)
                solveQueue << {k, v}
            end
        end

        oldSet = Set(String)
        otherQueue = Array(Tuple(String, MonkeyProblem)).new()
        loop do
            curM, curP = solveQueue.shift
            p "#{curM}, #{curP}" if DEBUG
            case {@mnk[curP[0]], @mnk[curP[1]]}
            when {Int64, Int64}
                p " solving for #{curM}" if DEBUG
                v1, v2 = @mnk[curP[0]].as(Int64), @mnk[curP[1]].as(Int64)
                if curM == "root"
                    return "#{v1} == #{v2}"
                end
                @mnk[curM] = performOp(v1, v2, curP[2])
            else
                p " Can't solve yet" if DEBUG
                otherQueue << {curM, curP}
            end

            if solveQueue.size == 0
                nSet = Set(String).new(otherQueue.map {|n,_| n})
                break if nSet == oldSet
                oldSet = nSet
                solveQueue = otherQueue
                otherQueue = Array(Tuple(String, MonkeyProblem)).new()
                pCount = solveQueue.size
            end
        end
        return nil
    end

    def buildEQ(start = "root")
        prob = @mnk[start]

        if start == "humn"
            return "humn"
        elsif prob.is_a?(Int64)
            return prob.to_s
        elsif prob.is_a?(MonkeyProblem)
            p1, p2, op = prob
            return "(" + buildEQ(p1) + (start == "root" ? "=" : op) + buildEQ(p2) + ")"
        else
            raise "hmm?"
        end
    end

    def reverseSolve(lhs : Int64, start = "root") : Int64
        prob = @mnk[start]

        if start == "root"
            raise "Bad root" if !prob.is_a?(MonkeyProblem)
            p1, p2, op = prob
            # p1 or p2 must be an int
            if @mnk[p1].is_a?(Int64)
                lhs = @mnk[p1].as(Int64)
                reverseSolve(lhs, p2)
            elsif @mnk[p2].is_a?(Int64)
                lhs = @mnk[p2].as(Int64)
                reverseSolve(lhs, p1)
            else
                raise "Bad Root"
            end
        elsif start == "humn"
            return lhs
        else
            p1, p2, op = prob.as(MonkeyProblem)
            p "reversing #{@mnk[p1]} #{op} #{@mnk[p2]} = #{lhs}" if DEBUG
            # p1 or p2 must be an int
            if @mnk[p1].is_a?(Int64)
                lhs = inverseOp(lhs, @mnk[p1].as(Int64), op, :p1)
                p lhs if DEBUG
                reverseSolve(lhs, p2)
            elsif @mnk[p2].is_a?(Int64)
                lhs = inverseOp(lhs, @mnk[p2].as(Int64), op, :p2)
                p lhs if DEBUG
                reverseSolve(lhs, p1)
            else
                raise "This is odd"
            end
        end
    end
end
    
class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        sv = Solver.new(input.mnk.clone)
        sv.solve
        n = sv.reverseSolve(0)
        n.to_s
    end
end