require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        # input.listyLists.map do |l1, l2|
        #     puts l1.to_s
        #     puts l2.to_s
        #     puts ""
        # end
        input.listyLists.map do |l1, l2|
            l1 <=> l2
        end.each_with_index(1).reduce(0) do |acc, n|
            v, i = n
            p "#{i}: #{v}"
            if v < 0
                 acc += i
            end
            acc
        end.to_s
    end
end