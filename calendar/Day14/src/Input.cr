alias Point = Tuple(Int32, Int32)
alias LineSegment = Tuple(Point, Point)

class LineGrid
    #Grid is y,x coordinates
    property grid : Array(Array(Char))
    getter xmin = 500
    getter xmax = -1
    getter ymin = 0
    getter ymax = -1

    def moveSand(sP : Point) : Point
        # y,x
        [{1,0}, {1,-1}, {1,1}].each do |dy, dx|
            if @grid[sP[1]+dy][sP[0]+dx] == '.'
                return {sP[0]+dx, sP[1]+dy}
            end
        end
        sP
    end

    def addSand(sP : Point, part = :one) : Symbol
        done = false
        lastP = sP
        curP = sP
        while !done
            curP = moveSand(curP)
            if curP == lastP
                done = true
            end
            lastP = curP

            if part == :one && curP[1] > ymax
                return :done
            elsif part == :two && curP == sP
                return :done
            end
        end

        @grid[curP[1]][curP[0]] = 'o'
        if curP[0] < xmin
            @xmin = curP[0]
        end
        if curP[1] < ymin
            @ymin = curP[1]
        end
        if curP[0] > xmax
            @xmax = curP[0]
        end
        if curP[1] > ymax
            @ymax = curP[1]
        end
        :moreSand
    end

    def drawFloor
        l = LineSegment.new({xmin-1000,ymax+2}, {xmax+1000,ymax+2})
        drawLine(l, true)
    end

    def drawLine(l : LineSegment, floor=false)
        p1, p2 = l
        if !floor
            l.each do |point|
                if point[0] < xmin
                    @xmin = point[0]
                end
                if point[1] < ymin
                    @ymin = point[1]
                end
                if point[0] > xmax
                    @xmax = point[0]
                end
                if point[1] > ymax
                    @ymax = point[1]
                end
            end
        end

        ystart, yend = p1[1] < p2[1] ? {p1[1], p2[1]} : {p2[1], p1[1]}
        xstart, xend = p1[0] < p2[0] ? {p1[0], p2[0]} : {p2[0], p1[0]}

        (ystart..yend).each do |y|
            (xstart..xend).each do |x|
                @grid[y][x] = '#'
            end
        end
    end

    def initialize(lS : Array(LineSegment))
        @grid = Array(Array(Char)).new()

        2000.times { @grid << Array(Char).new(2000, '.') }

        lS.each { |l| drawLine(l) }
    end

    def to_s
        s = ""
        (ymin..ymax).each do |i|
            s += "#{i} " + grid[i][xmin..xmax].join("") + "\n"
        end
        s += "\n"
    end
end

class Input
    property points = [] of Point
    getter segments : Array(LineSegment)
    getter grid : LineGrid

    def initialize(filename : String)
        @segments = Array(LineSegment).new()
        pPoint = {-1,-1}
        File.each_line(filename) do |line|
            @segments += line.split("->").map do |point| 
                x, y = point.split(",")
                tp = Point.new(x.to_i,y.to_i)
                if pPoint[0] == -1
                    pPoint = tp
                    nil
                    next
                end
                r = LineSegment.new(pPoint, tp)
                pPoint = tp
                r
            end.compact
            pPoint = {-1,-1}
        end
        @grid = LineGrid.new(segments)
    end
end