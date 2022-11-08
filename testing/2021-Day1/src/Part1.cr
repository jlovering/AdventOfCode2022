require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        prev_value = -1
        increasing = 0
        decreasing = 0

        @input.input.each do |value|
            if prev_value == -1
                p "(N/A)"
            elsif value > prev_value
                p "Increasing"
                increasing += 1
            elsif value < prev_value
                p "Decreasing"
                decreasing += 1
            else
                raise "Help"
            end
            prev_value = value
        end

        increasing
    end
end