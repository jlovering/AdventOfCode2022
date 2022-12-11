require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
        @monkeyies = [] of Monkey
        input.rawMonkey.each do |m|
            @monkeyies << Monkey.new(m, @monkeyies)
        end
    end

    def run()
        20.times do |i|
            @monkeyies.each do |m|
                m.monkeyAround()
            end
            puts "#{i}\n" + @monkeyies.map(&.to_s).join("\n") + "\n\n"
        end

        @monkeyies.map(&.inspections).sort[-2..-1].reduce(1) { |acc, i| acc*i }.to_s
    end
end