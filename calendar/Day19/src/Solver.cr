class Solver
    alias Resources = Array(Int32)
    alias RobotInventory = Array(Int32)

    getter roboRules : Tuple(RoboRule, RoboRule, RoboRule, RoboRule)
    getter knownSolutions = Hash(Tuple(Resources, Int32, RobotInventory), Int32).new()
    getter bestSolution = Hash(Int32, Int32).new()

    def initialize(@roboRules)
    end

    def roboName(i)
    case i
        when 3
            "Ore"
        when 2
            "Clay"
        when 1
            "Obsidian"
        when 0
            "Geode"
        end
    end

    def heuristicBest(resources : Resources, minute : Int32, robots : RobotInventory)
        # maxGeods = (0..minute).map do |i|
        #     (minute - i) * (robots[3] + i)
        # end.sum
        return resources[3] + minute
    end

    def solveMinute(resourcesS : Resources, minute : Int32, robotsS : RobotInventory) : Int32

        states = [Tuple.new(resourcesS, robotsS)]

        while minute > 0
            puts "#{25-minute}" if DEBUG
            newStates = Array(Tuple(Resources, RobotInventory)).new()

            states.each do |resources, robots|
                @roboRules.each_with_index do |costs, i|
                    resourcesBuy = resources.zip(costs.map(&.*(-1))).map(&.sum)
                    if resourcesBuy.all?{|v| v>= 0}
                        robotsN = robots.clone()
                        robotsN[i] += 1
                        resourcesNext = resourcesBuy.zip(robots).map(&.sum)
                        newStates << {resourcesNext, robotsN}
                        puts "\tbuilding #{roboName(i)} #{resourcesNext} #{robots}" if DEBUG
                    end
                end
                resourcesNext = resources.zip(robots).map(&.sum)
                newStates << {resourcesNext, robots}
                puts "\thording #{resourcesNext} #{robots}" if DEBUG
            end

            states = newStates.uniq.sort do |a, b|
                re1, ro1 = a
                re2, ro2 = b
                re2.zip(ro2).flatten <=> re1.zip(ro1).flatten
            end.first(5000)

            minute -= 1
        end

        states.max.first[0]
    end
end