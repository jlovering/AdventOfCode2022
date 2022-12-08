require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    # def look?(i : Int32, a : Array(Int32))
    #     target = a[0]
    #     a[1..].each do |t|
    #         if t > max
    #             return false
    #         end
    #     end
    #     return true
    # end

    def look_row(a : Array(Int32), j : Int32, flipped : Bool, reverse : Bool) : Set(Tuple(Int32, Int32))
        visible_set = Set(Tuple(Int32, Int32)).new()
        max = -1
        a.each_with_index do |t, i|
            if (t > max)
                max = t
                case {flipped, reverse}
                when {false, false}
                    visible_set.add({i,j})
                when {false, true}
                    visible_set.add({a.size-i-1,j})
                when {true, false}
                    visible_set.add({j, i})
                when {true, true}
                    visible_set.add({j, a.size-i-1})
                end
            end
        end
        visible_set
    end

    def look_all_rows(rs : Array(Array(Int32)), flipped : Bool) : Set(Tuple(Int32, Int32))
        visible_set = Set(Tuple(Int32, Int32)).new()
        rs.each_with_index do |a, j|
            visible_set = visible_set | look_row(a, j, flipped, false)
            visible_set = visible_set | look_row(a.reverse, j, flipped, true)
        end
        visible_set
    end

    def run()
        visible_set = Set(Tuple(Int32, Int32)).new()
        visible_set = look_all_rows(input.input, false)
        visible_set = visible_set | look_all_rows(input.input.transpose, true)
        visible_set.size.to_s
    end
end