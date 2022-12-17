alias Point = Tuple(Int32, Int32)

class Grid
    property grid = Set(Point).new()

    def initialize(@xmin=0, @xmax=6, @ymin=1)
        @ymax = 0
        @ymaxes = Array(Int32).new(xmax+1, 0)
    end

    def initialize(gridBase : Array(Int32), @xmin=0, @xmax=6, @ymin=1)
        @ymax = 0
        @ymaxes = Array(Int32).new(xmax+1, 0)
        # p gridBase
        gridBase.each_with_index do |ymax, x|
            (0..ymax).each do |y|
                @grid.add({x,y})
                newTall({x, y})
            end
        end
    end

    def atYMin?(y)
        y < @ymin
    end

    def atXMin?(x)
        x < @xmin
    end

    def atXMax?(x)
        x > @xmax
    end

    def findTallest
        @ymax
    end

    def newTall(pn : Point)
        @ymaxes[pn[0]] = [@ymaxes[pn[0]], pn[1]].max
        @ymax = @ymaxes.max
    end

    def findHeightBase
        @ymaxes.min
    end

    def gridGram : Array(Int32)
        shortest = findHeightBase
        @ymaxes.map {|v| v - shortest}
    end

    def row(y) : String
        (0..@xmax).map do |x|
            if @grid.includes?({x,y})
                "#"
            else
                "."
            end
        end.join()
    end

    def str(miny=@ymin, maxy=@ymax)
        (miny..maxy).map do |y|
            ("% 6.6d |" % (@ymax - y + miny)) + (0..@xmax).map do |x|
                if @grid.includes?({x,@ymax - y + miny})
                    "#"
                else
                    "."
                end
            end.join() + "|"
        end.join("\n") + "\n        +" + Array(Char).new(@xmax+1, '-').join() + "+\n"
    end
end


class Rock
    getter points = Set(Point).new()

    def initialize(@x : Int32, @y : Int32)
    end
    
    def left(g : Grid)
        nPoints = points.map do |pn|
            if g.atXMin?(pn[0]-1)
                return false
            end
            {pn[0]-1, pn[1]}
        end.to_set
        if (nPoints & g.grid).size != 0
            return false
        end
        @points = nPoints
        @x -= 1
        true
    end

    def right(g : Grid)
        nPoints = points.map do |pn|
            if g.atXMax?(pn[0]+1)
                return false
            end
            {pn[0]+1, pn[1]}
        end.to_set
        if (nPoints & g.grid).size != 0
            return false
        end
        @points = nPoints
        @x += 1
        true
    end

    def down(g : Grid)
        nPoints = points.map do |pn|
            if g.atYMin?(pn[1]-1)
                return false
            end
            {pn[0], pn[1]-1}
        end.to_set
        if (nPoints & g.grid).size != 0
            return false
        end
        @points = nPoints
        @y -= 1
        true
    end

    def fix_up()
        nPoints = points.map do |pn|
            {pn[0], pn[1]+1}
        end.to_set
        @points = nPoints
    end

    def fix(g : Grid)
        g.grid = g.grid | @points
        @points.each {|pn| g.newTall(pn)}
    end
end

class LongRockHorz < Rock
    def initialize(x, y)
        super
        @points = Set(Point).new [
            {x+0, y+0},
            {x+1, y+0},
            {x+2, y+0},
            {x+3, y+0}]
        fix_up
    end
end

class StarRock < Rock
    def initialize(x, y)
        super
        @points = Set(Point).new [
            {x+1, y+0},
            {x+0, y+1},
            {x+1, y+1},
            {x+2, y+1},
            {x+1, y+2}]
        fix_up
    end
end

class LRock < Rock
    def initialize(x, y)
        super
        @points = Set(Point).new [
            {x+0, y+0},
            {x+1, y+0},
            {x+2, y+0},
            {x+2, y+1},
            {x+2, y+2}]
        fix_up
    end
end

class LongRockVert < Rock
    def initialize(x, y)
        super
        @points = Set(Point).new [
            {x+0, y+0},
            {x+0, y+1},
            {x+0, y+2},
            {x+0, y+3}]
        fix_up
    end
end

class Boxy < Rock
    def initialize(x, y)
        super
        @points = Set(Point).new [
            {x+0, y+0},
            {x+1, y+0},
            {x+0, y+1},
            {x+1, y+1}]
        fix_up
    end
end