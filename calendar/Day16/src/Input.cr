require "cgl"

class Input
    getter valves = Hash(String, Tuple(Bool, Int32)).new()
    property valveG = CGL::Graph(String).new()

    def initialize(filename : String)
        File.each_line(filename) do |line|
            if (md = line.match(/^Valve ([A-Z]{2}) has flow rate=(\d+); tunnel(s?) lead(s?) to valve(s?) (.*)$/))
                vn, rate, connections = md[1], md[2], md[6].split(", ").map(&.chomp)
                if !valveG.has_vertex?(vn)
                    valveG.add_vertex(vn)
                end
                connections.each do |v|
                    if !valveG.has_vertex?(v)
                        valveG.add_vertex(v)
                    end
                    valveG.add_edge(vn, v)
                end
                valves[vn] = {false, rate.to_i}
            end
        end
    end
end