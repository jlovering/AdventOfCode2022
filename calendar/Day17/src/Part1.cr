require "./Input.cr"

class Part1
    property input : Input
    property vertOff = 3

    def initialize(file : String)
        @input = Input.new(file)
    end

    def completeRock(r : Rock, g : Grid)
        moving = true
        while moving
            # p r
            mov, _ = input.nextMove
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
        # p g
    end

    def run()
        grid = Grid.new()

        curRock = :longRockHorz

        (1..2022).each do |_|
            case curRock
            when :longRockHorz
                r = LongRockHorz.new(2, grid.findTallest + vertOff)
                curRock = :starRock
            when :starRock
                r = StarRock.new(2, grid.findTallest + vertOff)
                curRock = :lRock
            when :lRock
                r = LRock.new(2, grid.findTallest + vertOff)
                curRock = :longRockVert
            when :longRockVert
                r = LongRockVert.new(2, grid.findTallest + vertOff)
                curRock = :box
            when :box
                r = Boxy.new(2, grid.findTallest + vertOff)
                curRock = :longRockHorz
            end

            if (r_ = r)
                completeRock(r_, grid)
            end
            # puts grid.str()
            # puts "\n"
        end
        
        # puts grid.str()
        # puts "\n"

        grid.findTallest.to_s
    end
end