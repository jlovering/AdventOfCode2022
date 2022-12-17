require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
        @cycleLive = false
    end

    def completeRock(r : Rock, g : Grid) : Int32
        idx = -1
        moving = true
        while moving
            # p r
            mov, idx = input.nextMove
            if mov == Iterator::Stop::INSTANCE
                input.movesReset
                next
            end

            case mov
            when '<'
                # p "left"
                r.left(g)
                moving = r.down(g)
            when '>'
                # p "right"
                r.right(g)
                moving = r.down(g)
            end
        end
        # p r
        r.fix(g)
        return idx
    end

    def run()
        grid = Grid.new()

        curRock = :longRockHorz

        cycleFound = false
        cycleFinder = Hash(Tuple(Symbol, Int32, Array(Int32)), Tuple(Int64, Int32)).new()
        cycleCandidates = Hash(Tuple(Symbol, Int32, Array(Int32)), Tuple(Int64, Int64)).new()
        cycleSpec = {Symbol, Int64.new(0), Int32.new(0), Int64.new(0), Int32.new(0), Int64.new(0), Int32.new(0), Array(Int32).new()}
        rocks = Int64.new(0)
        m_idx = 0
        while !cycleFound
            if cycleFinder.has_key?({curRock, m_idx, grid.gridGram})
                # p "Found a cycle candidate"
                sRock, sHeight = cycleFinder[{curRock, m_idx, grid.gridGram}]
                # puts grid.str(sHeight, grid.findTallest)
                cycleSpec = {curRock,
                    sRock,
                    sHeight,
                    rocks,
                    grid.findTallest,
                    rocks - sRock,
                    grid.findTallest - sHeight,
                    grid.gridGram}
                cycleFound = true
                next
            else 
                cycleFinder[{curRock, m_idx, grid.gridGram}] = {rocks, grid.findTallest}
            end

            case curRock
            when :longRockHorz
                r = LongRockHorz.new(2, grid.findTallest+3)
                curRock = :starRock
            when :starRock
                r = StarRock.new(2, grid.findTallest+3)
                curRock = :lRock
            when :lRock
                r = LRock.new(2, grid.findTallest+3)
                curRock = :longRockVert
            when :longRockVert
                r = LongRockVert.new(2, grid.findTallest+3)
                curRock = :box
            when :box
                r = Boxy.new(2, grid.findTallest+3)
                curRock = :longRockHorz
            end

            if (r_ = r)
                m_idx = completeRock(r_, grid)
            end
            rocks += 1

            # if rocks % 1000 == 0
            #     puts "#{rocks}"
            #     puts grid.str(grid.findTallest-10)
            # end
            # puts grid.str
            # puts "\n"
        end
        
        curRock, sRock, sHeight, eRock, eHeight, dRock, dHeight, gridBase = cycleSpec
        residualRocks = (1000000000000 - eRock) % dRock
        n = Int64.new((Int64.new(1000000000000) - residualRocks - sRock) / dRock)

        # puts grid.str(grid.findTallest - 10)
        # puts grid.gridGram, gridBase

        # puts "Simulating residual: #{residualRocks}"

        grid = Grid.new(gridBase)
        sTall = grid.findTallest
        # puts grid.str, sTall

        while residualRocks > 0
            case curRock
            when :longRockHorz
                r = LongRockHorz.new(2, grid.findTallest+3)
                curRock = :starRock
            when :starRock
                r = StarRock.new(2, grid.findTallest+3)
                curRock = :lRock
            when :lRock
                r = LRock.new(2, grid.findTallest+3)
                curRock = :longRockVert
            when :longRockVert
                r = LongRockVert.new(2, grid.findTallest+3)
                curRock = :box
            when :box
                r = Boxy.new(2, grid.findTallest+3)
                curRock = :longRockHorz
            end

            if (r_ = r)
                completeRock(r_, grid)
            end
            residualRocks -= 1
            # puts grid.to_s
            # puts "\n"
        end

        cycleHeight = Int64.new(dHeight) * n
        # p sHeight, eHeight, cycleHeight, grid.findTallest
        (cycleHeight + sHeight + (grid.findTallest - sTall)).to_s
    end
end