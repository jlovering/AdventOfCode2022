require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def adjacent?(hPos : Array(Int32), tPos : Array(Int32))
        dx, dy = (hPos[0] - tPos[0]).abs, (hPos[1] - tPos[1]).abs
        # p "#{dx} #{dy}"
        case {dx, dy}
        when {0, 0}, {1, 0}, {0, 1}, {1, 1}
            true
        else
            false
        end
    end

    def moveTail(hPos : Array(Int32), tPos : Array(Int32)) : Array(Int32)
        if adjacent?(hPos, tPos)
            return tPos
        else
            dx, dy = hPos[0] - tPos[0], hPos[1] - tPos[1]
            case {dx.abs, dy.abs}
            when {2, 1}
                # move the diagonal
                tPos[1] += dy
                tPos[0] += dx//2
            when {1, 2}
                # move the diagonal
                tPos[1] += dy//2
                tPos[0] += dx
            when {2, 0}
                # just move x-1
                tPos[0] += dx//2
            when {0, 2}
                tPos[1] += dy//2
            when {2, 2}
                # sketchy diagonal move
                tPos[1] += dy//2
                tPos[0] += dx//2
            else
                raise "Don't know that move? #{dx} #{dy}"
            end
            if !adjacent?(hPos, tPos)
                raise "Bad move"
            end
            tPos
        end
    end

    def run()
        tailvisit = Set(Tuple(Int32,Int32)).new()
        tailvisit.add({0,0})
        rope = Array(Array(Int32)).new()
        10.times { rope << [0,0]}
        input.actions.each do |a|
            dir, count = a
            dx, dy = case dir
                when 'U'
                    {0, 1}
                when 'D'
                    {0, -1}
                when 'L'
                    {-1, 0}
                when 'R'
                    {1, 0}
                else
                    raise "Bad dir?"
                end
            count.times do 
                rope[0][0] += dx
                rope[0][1] += dy
                rope[1..].each_with_index(1) do |_,i|
                    t = moveTail(rope[i-1], rope[i])
                    rope[i][0], rope[i][1] = t[0], t[1]
                end
                tailvisit.add({rope[-1][0], rope[-1][1]})
            end
        end
        tailvisit.size.to_s
    end
end