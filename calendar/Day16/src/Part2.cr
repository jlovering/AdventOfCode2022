require "./Input.cr"

DEBUG = false

class Part2
    property input : Input
    # getter knowSolutions = Hash(Tuple(Tuple(String, Int32), Tuple(String, Int32), Int32, Hash(String, Tuple(Bool, Int32))), Int32).new()
    # getter knowSolutions = Hash(Tuple(String, String, Int32, Hash(String, Tuple(Bool, Int32))), Int32).new()
    
    getter bestForSet = Hash(Set(String), Int32).new()

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()

        valveSet = Set.new(input.valves.map do |k, v|
            k if v[1] > 0
        end.compact)

        completeValveSet = valveSet.to_a + ["AA"]

        countSets = 0
        countShorts = 0
        best = (valveSet.size//2..valveSet.size-1).map do |set1size|
            valveSet.to_a.combinations(set1size).map do |s1s|
                countSets += 2
                s1 = Set.new(s1s)
                s2 = valveSet - s1
                puts "Considering #{s1} #{s2}" if DEBUG
                if bestForSet.has_key?(s1)
                    puts " Have best value already for s1" if DEBUG
                    countShorts += 1
                    s1best = bestForSet[s1]
                else
                    valves = Hash(String, Tuple(Bool, Int32)).new()
                    s1.map do |v|
                        valves[v] = @input.valves[v]
                    end
                    s1best = Solver.new(valves, @input.valveG, completeValveSet).solveStep("AA", 26, valves, ["AA"])
                    bestForSet[s1] = s1best
                end
                if bestForSet.has_key?(s2)
                    puts " Have best value already for s2" if DEBUG
                    countShorts += 1
                    s2best = bestForSet[s2]
                else
                    valves = Hash(String, Tuple(Bool, Int32)).new()
                    s2.map do |v|
                        valves[v] = @input.valves[v]
                    end
                    s2best = Solver.new(valves, @input.valveG, completeValveSet).solveStep("AA", 26, valves, ["AA"])
                    bestForSet[s2] = s2best
                end
                puts " got #{s1best} #{s2best} (#{s1best + s2best})" if DEBUG
                s1best + s2best
            end.max
        end.max

        puts "Explored #{countSets} sets and had #{bestForSet.size} bests to find the best option, shorted #{countShorts}"
        best.to_s
    end
end