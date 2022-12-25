require "./Input.cr"

class P1Map
    getter m : Array(Array(Char))

    @mPrintClone : Array(Array(Char))

    def initialize(@m : Array(Array(Char)), example)
        @mPrintClone = @m.clone
    end

    @dirs = {
        left: {-1, 0},
        right: {1, 0},
        up: {0, -1},
        down: {0, 1}
    }

    @prnSym = {
        left: '<',
        right: '>',
        up: '^',
        down: 'v'
    }

    def str
        st = ""
        @mPrintClone.each do |r|
            st += r.join() + "\n"
        end
        st
    end

    def mark(pn : Point, dir : Symbol)
        @mPrintClone[pn[1]][pn[0]] = @prnSym[dir]
    end

    def self.rotate(dir : Symbol, rot : String) : Symbol
        case rot
        when "R"
            case dir
            when :left
                :up
            when :up
                :right
            when :right
                :down
            when :down
                :left
            else
                raise "Bad Heading"
            end
        when "L"
            case dir
            when :left
                :down
            when :down
                :right
            when :right
                :up
            when :up
                :left
            else
                raise "Bad Heading"
            end
        when "N"
            dir
        else
            raise "Bad rotation"
        end
    end

    def findStart(pn : Point = {0,0}) : Point
        dx = 0
        loop do
            # p @m[ty][pn[0]]
            break if @m[pn[1]][dx] != ' '
            dx += 1
        end
        {dx, 0}
    end

    def verticalLoop(pn : Point, dir : Symbol) : Int32
        case dir
        when :down
            ty = 0
            loop do
                # p ty, (@m[ty].size-1)
                begin
                    break if @m[ty][pn[0]] != ' '
                rescue
                end
                ty += 1
            end
            ty
        when :up
            ty = @m.size-1
            loop do
                begin
                    break if @m[ty][pn[0]] != ' '
                rescue
                end
                ty -=1
            end
            ty
        else
            raise "Can't vert loop on non vert"
        end
    end

    # Up is down and down is up!
    def checkMove(pn : Point, dir : Symbol) : Point
        dx, dy = @dirs[dir]

        #p pn, @m[pn[1]][pn[0]]
        raise "Bad start #{pn}" if @m[pn[1]][pn[0]] != '.'
        
        #get the row we are thinking about
        r = @m[pn[1]]

        # p ""
        #bounds check
        candx = pn[0] + dx
        candy = pn[1] + dy
        if candx > r.size-1
            # p "right edge loop to left"
            candx = findStart(pn)[0]
        elsif candx < 0
            # p "left edge, loop to right"
            candx = r.size-1
        elsif dx.negative? && candy < (@m.size-1) && @m[candy][candx] == ' '
            candx = r.size-1
        end
        if candy > @m.size-1 || (dy.positive? && ((@m[candy].size-1) < pn[0] || @m[candy][pn[0]] == ' '))
            # p "loop around to top"
            candy = verticalLoop(pn, :down)
        elsif candy < 0 || (dy.negative? && ((@m[candy].size-1) < pn[0] || @m[pn[1] + dy][pn[0]] == ' '))
            # p "loop around to bottom"
            candy = verticalLoop(pn, :up)
        end

        # p candx, candy, @m[candy][candx]
        if @m[candy][candx] == '.'
            return {candx, candy}
        else
            return pn
        end
    end
end

class Part1
    property input : Input(P1Map)

    def initialize(file : String)
        @input = Input(P1Map).new(file)
    end

    def run()
        curPn = input.m.findStart
        curDir = :right
        i = 0
        input.r.each do |dist, rot|
            puts "#{curPn} #{curDir} #{dist} #{rot}"
            dist.times do
                curPn = input.m.checkMove(curPn, curDir)
                input.m.mark(curPn, curDir)
            end
            curDir = P1Map.rotate(curDir, rot)
            puts " #{curPn} #{curDir}"
            # puts input.m.str
            # p curPn, curDir
            i += 1
            # break if i == 4
        end

        puts "#{i} moves completed"

        puts input.m.str
        numSym = {
            left: 2,
            right: 0,
            up: 3,
            down: 1
        }
        (1000*(curPn[1]+1) + 4*(curPn[0]+1) + numSym[curDir]).to_s
    end
end