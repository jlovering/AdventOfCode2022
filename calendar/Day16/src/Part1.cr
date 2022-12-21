require "./Input.cr"
require "cgl"

class Part1
    property input : Input
    getter knowSolutions = Hash(Tuple(String, Int32, Hash(String, Tuple(Bool, Int32))), Int32).new()

    def initialize(file : String)
        @input = Input.new(file)
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

    def solveStep(curNode, timeRemaining, valves : Hash(String, Tuple(Bool, Int32)), forwardPath = [] of String) : Int32?
        # p "#{forwardPath.join("->")}, #{timeRemaining}, #{valves.map{|k, v| k.to_s + "=" + v[0].to_s}}"
        if knowSolutions.has_key?({curNode, timeRemaining, valves})
            # p "-> #{forwardPath.join("->")} (shorted) #{knowSolutions[{curNode, timeRemaining, valves}]}"
            return knowSolutions[{curNode, timeRemaining, valves}]
        end
        
        actions = valves.map do |k, v|
            if (k != curNode) && !v[0] && (v[1] > 0)
                # p "#{curNode} #{k}"
                begin
                    path = @input.valveG.shortest_path(curNode, k)
                rescue
                    next
                end
                dist = path.size - 1
                time_to = dist + 1
                time_at = (timeRemaining - time_to)
                release = time_to * curRelease(valves)
                if time_at == 0
                    # p "-> #{forwardPath.join("->")} path completed (out of time)"
                    knowSolutions[{curNode, timeRemaining, valves}] = release
                    release
                elsif time_at < 0
                    # p "-> #{forwardPath.join("->")} path completed (over jump)"
                    knowSolutions[{curNode, timeRemaining, valves}] = (time_to + time_at) * curRelease(valves)
                    (time_to + time_at) * curRelease(valves)
                else
                    valve_N = hashClone(valves)
                    valve_N[k] = {true, valves[k][1]}
                    if (tS = solveStep(k, time_at, valve_N, Array(String).new() + (forwardPath + [k])))
                        knowSolutions[{curNode, timeRemaining, valves}] = tS + release
                        # p "->#{forwardPath.join("->")} #{tS} + #{release} #{tS + release}"
                        tS + release
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
            knowSolutions[{curNode, timeRemaining, valves}] = timeRemaining * curRelease(valves)
            timeRemaining * curRelease(valves)
        end
    end

    def run()
        solveStep("AA", 30, input.valves, ["AA"]).to_s
    end
end