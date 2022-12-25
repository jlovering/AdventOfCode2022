require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end


    def run()
        dSum = input.input.map do |s|
            SNAFU.new(s)
        end.sum { |sn| sn.decimal }
        SNAFU.new(dSum).snafu.join
    end
end