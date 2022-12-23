require "./Input.cr"

DEBUG = false

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    @moves : Array(Tuple(Symbol, Point))
    @moves = [
        Tuple.new(:n, {0,-1}), #N
        Tuple.new(:s, {0,1}), #S
        Tuple.new(:w, {-1,0}), #W
        Tuple.new(:e, {1,0}) #E
    ]

    @moveChecks = {
        n: [{0,-1}, {1,-1}, {-1,-1}],
        s: [{0,1}, {1,1}, {-1,1}],
        w: [{-1,0}, {-1,1}, {-1,-1}],
        e: [{1,0}, {1,1}, {1,-1}]
    }

    @looks = [
        {0,-1}, #N
        {1,-1}, #NE
        {1,0}, #E
        {1,1}, #SE
        {0,1}, #S
        {-1,1}, #SW
        {-1,0}, #W
        {-1,-1} #NW
    ]

    def bounds
        minx, miny = 0, 0
        maxx, maxy = 0, 0

        @input.elves.each do |elv|
            minx = [minx, elv[0]].min
            maxx = [maxx, elv[0]].max
            miny = [miny, elv[1]].min
            maxy = [maxy, elv[1]].max
        end
        {minx, maxx, miny, maxy}
    end

    def computeRect
        minx, maxx, miny, maxy = bounds
        ((maxx + 1 - minx) * (maxy + 1 - miny)) - @input.elves.size
    end

    def anybodyAround?(pn : Point) : Bool
        @looks.each do |dx, dy|
            if @input.elves.includes?({pn[0]+dx, pn[1]+dy})
                return true
            end
        end
        false
    end

    def moveCheck(pn : Point, dir : Symbol) : Bool
        @moveChecks[dir].map do |dx, dy|
            @input.elves.includes?({pn[0]+dx, pn[1]+dy})
        end.all?(false)
    end

    def str
        minx, maxx, miny, maxy = bounds
        
        st = ""
        (miny..maxy).each do |y|
            (minx..maxx).each do |x|
                if @input.elves.includes?({x, y})
                    st += "#"
                else 
                    st += "."
                end
            end
            st += "\n"
        end
        st
    end

    def run()
        moveQueueHash = Hash(Point, Array(Point)).new()

        #First half, figure out moves
        10.times do
            @input.elves.each do |elf|
                if anybodyAround?(elf)
                    @moves.each do |mv|
                        dir, mvd = mv
                        dx, dy = mvd
                        mv = {elf[0]+dx, elf[1]+dy}
                        if moveCheck(elf, dir)
                            if !moveQueueHash.has_key?(mv)
                                p "#{elf}, #{mv}" if DEBUG
                                moveQueueHash[mv] = [elf]
                            else
                                p "#{elf}, #{mv}, #{moveQueueHash[mv]}" if DEBUG
                                moveQueueHash[mv] << elf
                            end
                            break
                        end
                    end
                end
            end

            p "Intial #{moveQueueHash}" if DEBUG

            if moveQueueHash.size == 0
                p "ran out of motion"
                return computeRect.to_s
            end

            #Second half, deside moves, keep only uniques
            moveQueue = moveQueueHash.map do |mv,elf|
                if elf.size > 1
                    nil
                else
                    {mv, elf[0]}
                end
            end.compact

            p "Culled #{moveQueue}" if DEBUG

            #Second second half, move
            moveQueue.each do |mv, elf|
                @input.elves.delete(elf)
                @input.elves.add(mv)
            end

            moveQueueHash.clear
            moveQueue.clear
            mv = @moves.shift
            @moves << mv
        end

        puts str

        p "Finished 10 rounds"
        return computeRect.to_s
    end
end