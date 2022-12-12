require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def checkNeighbors(g : Array(Array(Int32)), c : Point) : Array(Point)
        r = Array(Point).new()
        [{1,0}, {-1,0}, {0,1}, {0,-1}].each do |dx, dy|
            nP = {c[0] + dx, c[1] + dy}
            if nP[0] >= 0 && nP[0] < g[0].size && nP[1] >= 0 && nP[1] < g.size && 
                g[nP[1]][nP[0]] - g[c[1]][c[0]] >= -1
                r << nP
            end
        end
        r
    end

    def qIn(q : Array(BfsItem), vis : Array(Point), nP : BfsItem)
        if nP[0].in?(vis)
            return
        end
        q.reject!{ |v| v[0][0] == nP[0][0] && v[0][1] == nP[0][1]}
        q << nP
        q.sort{|a, b| a[1] <=> b[1]}.reverse!
    end

    def run()        
        q = Array(BfsItem).new()
        q << {input.endP, Array(Point).new()}
        visited = Array(Point).new()

        while q.size > 0
            n, cost = q.shift()
            visited << n
            if n.in?(input.startP)
                return cost.size.to_s
            end
            checkNeighbors(input.heightMap, n).each { |nP| qIn(q, visited, {nP, cost + [n]})}
        end
        ""
    end
end