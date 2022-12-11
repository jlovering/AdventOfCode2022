require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
        @monkeyies = [] of Monkey
        worryProduct = 1
        input.rawMonkey.each do |m|
            mO = Monkey.new(m, @monkeyies, :mod)
            worryProduct *= mO.testdiv
            @monkeyies << mO
        end
        @monkeyies.each_with_index do |_, i|
            @monkeyies[i].worryReduction = worryProduct
        end
    end

    def run()
        10000.times do |i|
            @monkeyies.each do |m|
                m.monkeyAround()
            end
            if [1, 20, 100, 200, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000].includes?(i+1)
                puts "#{i+1}\n"
                puts @monkeyies.map(&.to_s).join("\n") + "\n"
                puts @monkeyies.map { |m| "Monkey #{m.name} #{m.inspections}" }.join("\n") + "\n"
                puts "\n"
            end
        end

        @monkeyies.map(&.inspections).sort[-2..-1].reduce(1.to_i64) { |acc, i| acc*i }.to_s
    end
end