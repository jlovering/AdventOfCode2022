require "./Input.cr"

# DEBUG = false

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()

        solveQueue = Array(Tuple(String, MonkeyProblem)).new()

        input.mnk.each do |k, v|
            if v.is_a?(MonkeyProblem)
                solveQueue << {k, v}
            end
        end

        while solveQueue.size > 0 && input.mnk["root"].is_a?(MonkeyProblem)
            curM, curP = solveQueue.shift
            p "#{curM}, #{curP}" if DEBUG
            case {input.mnk[curP[0]], input.mnk[curP[1]]}
            when {Int64, Int64}
                p " solving for #{curM}" if DEBUG
                v1, v2 = input.mnk[curP[0]].as(Int64), input.mnk[curP[1]].as(Int64)
                input.mnk[curM] = performOp(v1, v2, curP[2])
            else
                p " Can't solve yet" if DEBUG
                solveQueue << {curM, curP}
            end
            p solveQueue.size if DEBUG
        end
        
        if input.mnk["root"].is_a?(MonkeyProblem)
            raise "Didn't complete"
        end

        input.mnk["root"].to_s
    end
end