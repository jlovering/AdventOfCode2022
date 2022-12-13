require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        p_2 = Input.parsePacket("[[2]]")
        p_2i = 9999
        p_6 = Input.parsePacket("[[6]]")
        p_6i = 9999
        input.listyLists.map { |l1, l2| [l1, l2] }.flatten.sort.each_with_index(1) do |l, i|
            if p_2 <=> l < 0 && i < p_2i
                p_2i = i
            end
            if p_6 <=> l < 0 && i < p_6i
                p_6i = i + 1
            end
        end
        (p_2i*p_6i).to_s
    end
end