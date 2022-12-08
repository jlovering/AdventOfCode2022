require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def look(i : Int32, j : Int32, i_i : Int32, j_i : Int32) : Int32
        count = 0
        t = input.input[j][i]
        i += i_i
        j += j_i
        while i >= 0 && i < input.input[0].size && j >= 0 && j < input.input.size
            if input.input[j][i] >= t
                return count + 1
            else
                count += 1
            end
            i += i_i
            j += j_i
        end
        count
    end

    def compute_score(i : Int32, j : Int32) : Int32
        [{1,0}, {-1,0}, {0,1}, {0,-1}].reduce(1) do |acc, p|
            acc *= look(i, j, p[0], p[1])
        end
    end

    def run()
        scenic_scores = Hash(Tuple(Int32, Int32), Int32).new()
        input.input.each_with_index do |r, j|
            r.each_with_index do |t, i|
                scenic_scores.[{i,j}] = compute_score(i, j)
            end
        end
        scenic_scores.values.max.to_s
    end
end