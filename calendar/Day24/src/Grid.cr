alias Point = Tuple(Int32, Int32)

Moves = {
        up: {0, -1},
        down: {0, 1},
        left: {-1, 0},
        right: {1, 0}
    }

class Blizzard
    getter dir : Symbol

    def initialize(@curPoint : Point, @dir : Symbol, @grid : Grid)
    end

    def moveStorm
        dx, dy = Moves[@dir]

        candx = @curPoint[0] + dx
        candy = @curPoint[1] + dy

        if @grid.in_bounds?({candx, candy})
            @curPoint = {candx, candy}
        else
            # p "loop"
            @curPoint = @grid.loopBounds({candx, candy})
        end
    end

    @dirPrint = {
        up: "^",
        down: "v",
        left: "<",
        right: ">"
    }

    def to_s
        return "#{@dirPrint[@dir]}"
    end
end

class Grid
    @storms = Hash(Point, Array(Blizzard)).new()

    getter homeP : Point

    def initialize(@raw : Array(String))
        @homeP = {@raw[0].size-2, @raw.size-1}
        @raw.each_with_index do |l,y|
            l.chars.each_with_index do |c,x|
                case c
                    when '>'
                        @storms[{x, y}] = [Blizzard.new({x,y}, :right, self)]
                    when '<'
                        @storms[{x, y}] = [Blizzard.new({x,y}, :left, self)]
                    when '^'
                        @storms[{x, y}] = [Blizzard.new({x,y}, :up, self)]
                    when 'v'
                        @storms[{x, y}] = [Blizzard.new({x,y}, :down, self)]
                end
            end
        end
    end

    def in_bounds?(pn : Point) : Bool #True is in bounds
        (pn[0] > 0) && (pn[0] < @raw[0].size-1) && (pn[1] > 0) && (pn[1] < @raw.size-1)
    end

    def loopBounds(pn : Point) : Point
        case pn[0]
            when .< 1
                return {@raw[0].size-2, pn[1]}
            when .> @raw[0].size-2
                return {1, pn[1]}
        end

        case pn[1]
        when .< 1
            return {pn[0], @raw.size-2}
        when .> @raw.size-2
            return {pn[0], 1}
        end
        raise "Hyperloop failed..."
    end

    def has_storm?(pn : Point) : Bool
        @storms.has_key?(pn)
    end

    def p_can_move?(pn : Point) : Bool #can this square be moved into
        return true if pn == @homeP
        return true if pn == {1,0}
        in_bounds?(pn) && !has_storm?(pn) && @raw[pn[1]][pn[0]] != '#'
    end

    @dirInv = {
        up: :down,
        down: :up,
        left: :right,
        right: :left,
    }
    def p_safe?(pn : Point) : Bool #true if no storms incomming
        Moves.each do |dir, mv|
            dx, dy = mv
            candp = {pn[0] + dx, pn[1] + dy}
            if @storms.has_key?(candp)
                @storms[candp].each do |s|
                    if s.dir == @dirInv[dir]
                        return false
                    end
                end
            end
        end
        true
    end

    def simulate_next
        #simulate 1 step
        newStorms = Hash(Point, Array(Blizzard)).new()
        @storms.each do |k, sA|
            sA.each_with_index do |s, i|
                np = s.moveStorm
                if newStorms.has_key?(np)
                    newStorms[np] << s
                else
                    newStorms[np] = [s]
                end
            end
        end
        @storms = newStorms
    end

    def self.manDist(p1 : Point, p2 : Point)
        (p2[0] - p1[0]).abs + (p2[1] - p1[1]).abs
    end

    def to_s
        st = "#." + "#" * (@raw[0].size-2) + "\n"
        (1...@raw.size-1).each do |y|
            st += "#"
            (1...@raw[y].size-1).each do |x|
                if @storms.has_key?({x,y})
                    if @storms[{x,y}].size > 1
                        st += @storms[{x,y}].size.to_s
                    else
                        st += @storms[{x,y}][0].to_s
                    end
                else
                    st += "."
                end
            end
            st += "#\n"
        end
        st += "#" * (@raw[0].size-2) + ".#\n"
    end
end