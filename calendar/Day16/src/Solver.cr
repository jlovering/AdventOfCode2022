class Solver
    getter knowSolutions = Hash(Tuple(String, Int32, Hash(String, Tuple(Bool, Int32))), Int32).new()
    getter pathCache = Hash(Tuple(String, String), Int32).new()
    getter knownBest = Hash(Int32, Int32).new()
    getter valves : Hash(String, Tuple(Bool, Int32))
    getter valveG : CGL::Graph(String)

    @badPaths = 0
    @shortedPaths = 0
    @allValves = 0

    def initialize(@valves : Hash(String, Tuple(Bool, Int32)), @valveG : CGL::Graph(String), @allNodes : Array(String))
        @allValves = @valves.map do |_, v|
            v[1]
        end.sum

        pathPreCache
    end

    def curRelease(valves : Hash(String, Tuple(Bool, Int32)))
        valves.map do |_, v|
            if v[0]
                v[1]
            else
                0
            end
        end.sum
    end

    def hashClone(src : Hash(String, Tuple(Bool, Int32)))
        n = Hash(String, Tuple(Bool, Int32)).new()
        src.each do |k, v|
            n[k] = v
        end
        n
    end

    def memorizeReturn(curNode, timeRemaining, valves, value)
        if @knownBest.has_key?(timeRemaining)
            @knownBest[timeRemaining] = [knownBest[timeRemaining], value].max
        else
            @knownBest[timeRemaining] = value
        end
        @knowSolutions[{curNode, timeRemaining, valves}] = value
        return value
    end

    def huristicBest(timeRemaining, release)
        (timeRemaining - 1) * @allValves + release
    end

    def pathPreCache
        @allNodes.combinations(2).map do |k|
            d1, d2 = k
            p1 = @valveG.shortest_path(d1, d2)
            #paths have both start and end... so -1 +1 (fot the action)
            @pathCache[{d1, d2}] = p1.size
            @pathCache[{d2, d1}] = p1.size
        end
    end

    def solveStep(curNode, timeRemaining, valves : Hash(String, Tuple(Bool, Int32)), forwardPath = [] of String) : Int32?
        p "#{forwardPath.join("->")}, #{timeRemaining}, #{valves.map{|k, v| k.to_s + "=" + v[0].to_s}}" if DEBUG
        if knowSolutions.has_key?({curNode, timeRemaining, valves})
            p "-> #{forwardPath.join("->")} (shorted) #{knowSolutions[{curNode, timeRemaining, valves}]}" if DEBUG
            return knowSolutions[{curNode, timeRemaining, valves}]
        end
        
        actions = valves.map do |k, v|
            if (k != curNode) && !v[0] && (v[1] > 0)
                p "#{curNode} #{k}" if DEBUG

                path = @pathCache[{curNode, k}]

                dist = path - 1
                time_to = dist + 1
                time_at = (timeRemaining - time_to)
                release = time_to * curRelease(valves)

                if @knownBest.has_key?(time_at) && huristicBest(time_at, release) < @knownBest[time_at]
                    puts "Abandoning non-viable #{huristicBest(time_at, release)} < #{@knownBest[time_at]}" if DEBUG
                    @badPaths += 1
                    return memorizeReturn(curNode, timeRemaining, valves, 0)
                end

                if time_at == 0
                    p "A -> #{forwardPath.join("->")} path completed (out of time)" if DEBUG
                    memorizeReturn(curNode, timeRemaining, valves, release)
                elsif time_at < 0
                    p "B -> #{forwardPath.join("->")} path completed (over jump)" if DEBUG
                    memorizeReturn(curNode, timeRemaining, valves, (time_to + time_at) * curRelease(valves))
                else
                    valve_N = hashClone(valves)
                    valve_N[k] = {true, valves[k][1]}
                    if (tS = solveStep(k, time_at, valve_N, Array(String).new() + (forwardPath + [k])))
                        p "C ->#{forwardPath.join("->")} #{tS} + #{release} #{tS + release}" if DEBUG
                        memorizeReturn(curNode, timeRemaining, valves, tS + release)
                    else
                        nil
                    end
                end
            else
                # p "-> #{forwardPath.join("->")} don't like #{k}"
                nil
            end
        end.compact.sort.reverse

        if actions.size >= 1
            actions[0]
        else
            # p "->#{forwardPath.join("->")} no actions"
            p "D ->#{forwardPath.join("->")} #{timeRemaining * curRelease(valves)}" if DEBUG
            memorizeReturn(curNode, timeRemaining, valves, timeRemaining * curRelease(valves))
        end
    end
end