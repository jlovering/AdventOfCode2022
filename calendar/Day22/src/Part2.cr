require "./Input.cr"

alias CubePoint = Tuple(Symbol, Int32, Int32)
alias Line = Tuple(Point, Point)

class P2Map
    getter cube : Hash(Symbol,Array(Array(Char)))
    getter cubeInOrigin : NamedTuple(a: Tuple(Int32, Int32), b: Tuple(Int32, Int32), c: Tuple(Int32, Int32), d: Tuple(Int32, Int32), e: Tuple(Int32, Int32), f: Tuple(Int32, Int32))

    @mPrintClone : Hash(Symbol,Array(Array(Char)))

    @example = false
    getter startP : CubePoint

    #{fromface, toface} = {Edge Line1, Edge Line2, Rotation}
    @cubemapping = Hash(Tuple(Symbol, Symbol), Tuple(Symbol, Line, Line, String)).new()
    
    def initialize(m : Array(Array(Char)), @example = true)
        @cube = Hash(Symbol,Array(Array(Char))).new()
        if @example
            @faceMax = 3
            @cubeInOrigin = {
                a: Tuple.new(8,0),
                b: Tuple.new(0,4),
                c: Tuple.new(4,4),
                d: Tuple.new(8,4),
                e: Tuple.new(8,8),
                f: Tuple.new(8,8)
            }

            cube[:a] = Array(Array(Char)).new()
            4.times do 
                l = m.shift
                fl = l.join.lstrip.rstrip.chars
                cube[:a] << fl
            end
            cube[:b] = Array(Array(Char)).new()
            cube[:c] = Array(Array(Char)).new()
            cube[:d] = Array(Array(Char)).new()
            4.times do 
                l = m.shift
                fl = l.join.lstrip.rstrip.chars
                cube[:b] << fl[0...4]
                cube[:c] << fl[4...8]
                cube[:d] << fl[8...12]
            end
            cube[:e] = Array(Array(Char)).new()
            cube[:f] = Array(Array(Char)).new()
            4.times do 
                l = m.shift
                fl = l.join.lstrip.rstrip.chars
                cube[:e] << fl[0...4]
                cube[:f] << fl[4...8]
            end

            #Mappings for a
            generateMapping(:a, :f, :right, :right, true, "I")
            generateMapping(:a, :d, :down, :up, false, "N")
            generateMapping(:a, :c, :left, :up, false, "L")
            generateMapping(:a, :b, :up, :up, true, "I")

            #Mappings for e
            generateMapping(:e, :f, :right, :left, false, "N")
            generateMapping(:e, :b, :down, :down, true, "I")
            generateMapping(:e, :c, :left, :down, true, "R")
            generateMapping(:e, :d, :up, :down, false, "N")

            #Mappings for d (up/down are all done)
            generateMapping(:d, :c, :left, :right, false, "N")
            generateMapping(:d, :f, :right, :up, true, "R")

            #Mappings for b
            generateMapping(:b, :c, :right, :left, false, "N")
            generateMapping(:b, :f, :left, :down, true, "R")
            

            #c and f are all done

            # p @cubemapping
        else
            @faceMax = 49
            @cubeInOrigin = {
                a: Tuple.new(50,0),
                b: Tuple.new(100,0),
                c: Tuple.new(50,50),
                d: Tuple.new(50,100),
                e: Tuple.new(0,100),
                f: Tuple.new(0,150)
            }
            cube[:a] = Array(Array(Char)).new()
            cube[:b] = Array(Array(Char)).new()
            50.times do
                l = m.shift
                fl = l.join.lstrip.rstrip.chars
                cube[:a] << fl[0..50]
                cube[:b] << fl[50..100]
            end
            
            cube[:c] = Array(Array(Char)).new()
            50.times do 
                l = m.shift
                fl = l.join.lstrip.rstrip.chars
                cube[:c] << fl[0...50]
            end

            cube[:e] = Array(Array(Char)).new()
            cube[:d] = Array(Array(Char)).new()
            50.times do 
                l = m.shift
                fl = l.join.lstrip.rstrip.chars
                cube[:e] << fl[0...50]
                cube[:d] << fl[50...100]
            end

            cube[:f] = Array(Array(Char)).new()
            50.times do 
                l = m.shift
                fl = l.join.lstrip.rstrip.chars
                cube[:f] << fl[0...50]
            end

            #Mappings for c
            generateMapping(:c, :a, :up, :down, false, "N")
            generateMapping(:c, :d, :down, :up, false, "N")
            #less obvious
            generateMapping(:c, :b, :right, :down, false, "L")
            generateMapping(:c, :e, :left, :up, false, "L")

            #Mappings for f
            generateMapping(:f, :e, :up, :down, false, "N")
            #less obvious
            generateMapping(:f, :d, :right, :down, false, "L")
            generateMapping(:f, :b, :down, :up, false, "N")
            generateMapping(:f, :a, :left, :up, false, "L")

            #Mappings for d (up/down are all done)
            generateMapping(:d, :e, :left, :right, false, "N")
            generateMapping(:d, :b, :right, :right, true, "I")

            #Mappings for a
            generateMapping(:a, :b, :right, :left, false, "N")
            generateMapping(:a, :e, :left, :left, true, "I")
            

            #c and f are all done
        end
        @startP = {:a,0,0}
        @mPrintClone = @cube.clone
        sanityCheckMapping
        raise "Map not parsed #{m}" if m.size != 0
    end

    def sanityCheckMapping
        [:a, :b, :c, :d, :e, :f].each do |face|
            [:up, :down, :left, :right].each do |dir|
                raise "Missing mapping" if !@cubemapping.has_key?({face, dir})
            end
        end
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
        if @example
            4.times do |i|
                st += " "*2*4 + @mPrintClone[:a][i].join("") + "\n"
            end
            4.times do |i|
                st += @mPrintClone[:b][i].join() + @mPrintClone[:c][i].join() + @mPrintClone[:d][i].join() + "\n"
            end
            4.times do |i|
                st += " "*2*4 + @mPrintClone[:e][i].join() + @mPrintClone[:f][i].join() + "\n"
            end
        else
            @mPrintClone.each do |k, v|
                st += "Side #{k}\n"
                v.each do |r|
                    st += r.join() + "\n"
                end
            end
        end
        st
    end

    def mark(pn : CubePoint, dir : Symbol, final = false)
        @mPrintClone[pn[0]][pn[2]][pn[1]] = @prnSym[dir]
        if final
            @mPrintClone[pn[0]][pn[2]][pn[1]] = 'F'
        end
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
        when "I"
            case dir
            when :left
                :right
            when :right
                :left
            when :down
                :up
            when :up
                :down
            else
                raise "Bad Heading"
            end
        else
            raise "Bad rotation"
        end
    end

    def self.faceInvertRotation(rot : String)
        case rot
        when "R"
            "L"
        when "L"
            "R"
        when "I"
            "I"
        when "N"
            "N"
        else
            raise "Bad rotator"
        end
    end

    def generateFaceLine(dir : Symbol, flip = false) : Line
        case dir
        when :down
            l= Line.new({0, @faceMax}, {@faceMax, @faceMax})
        when :right
            l = Line.new({@faceMax,0}, {@faceMax, @faceMax})
        when :left
            l = Line.new({0,0}, {0, @faceMax})
        when :up
            l = Line.new({0,0}, {@faceMax, 0})
        else
            raise "Bad dir"
        end

        if flip
            {l[1], l[0]}
        else
            l
        end
    end

    #Helper function to generate the bidirectional mapping
    def generateMapping(fromFace : Symbol, toFace : Symbol, directionOfFromFace : Symbol, directionOfToFace : Symbol, flip : Bool, rot : String)
        fromEntryK = {fromFace, directionOfFromFace}
        raise "Arready inited" if @cubemapping.has_key?(fromEntryK)
        fromEntryV = {toFace, generateFaceLine(directionOfFromFace), generateFaceLine(directionOfToFace, flip), rot}
        @cubemapping[fromEntryK] = fromEntryV

        toEntryK = {toFace, directionOfToFace}
        raise "Arready inited" if @cubemapping.has_key?(toEntryK)
        toEntryV = {fromFace, generateFaceLine(directionOfToFace), generateFaceLine(directionOfFromFace, flip), P2Map.faceInvertRotation(rot)}
        @cubemapping[toEntryK] = toEntryV
    end

    def generateLinePoints(l : Line) : Array(Point)
        p1, p2 = l
        xr = (p2[0] - p1[0]).abs
        yr = (p2[1] - p1[1]).abs

        # p l, xr, yr
        raise "Inproper Edge" if ((xr != @faceMax && yr != 0) && (xr != 0 || yr != @faceMax))
        
        pts = Array(Point).new()
        if xr == @faceMax
            dx = (p2[0] - p1[0]) // xr
            if dx > 0
                x = 0
            else
                x = xr
            end
            (xr+1).times do
                pts << {x, p1[1]}
                x += dx
            end
        elsif yr == @faceMax
            dy = (p2[1] - p1[1]) // yr
            if dy > 0
                y = 0
            else
                y = yr
            end
            (yr+1).times do
                pts << {p1[0], y}
                y += dy
            end
        else
            raise "?"
        end
        pts
    end
    
    def offFaceMove(pn : CubePoint, dir : Symbol) : {CubePoint, Symbol}
        curFace, curX, curY = pn
        curPn = {curX, curY}
        toFace, fromEdgeLine, toEdgeLine, rot = @cubemapping[{curFace, dir}]

        fromEdgePts = generateLinePoints(fromEdgeLine)
        toEdgePts = generateLinePoints(toEdgeLine)
        # p curPn, fromEdgeLine, fromEdgePts, toEdgeLine, toEdgePts
        offset = fromEdgePts.index!(&.==(curPn))
        destPn = toEdgePts[offset]
        # p dir, rot, P2Map.rotate(dir, rot)
        Tuple.new({toFace, destPn[0], destPn[1]}, P2Map.rotate(dir, rot))
    end

    # Up is down and down is up!
    def checkMove(pn : CubePoint, dir : Symbol) : {CubePoint, Symbol}
        dx, dy = @dirs[dir]

        #p pn, @m[pn[1]][pn[0]]
        raise "Bad start #{pn}" if @cube[pn[0]][pn[2]][pn[1]] != '.'
        
        #bounds check
        canddir = dir
        candface = pn[0]
        candx = pn[1] + dx
        candy = pn[2] + dy
        if candx > @faceMax || candx < 0 || candy > @faceMax || candy < 0
            #move is off grid, so do some magic
            candp, canddir = offFaceMove(pn, dir)
            candface, candx, candy = candp
        else
            #in grid move is done 
            nil
        end

        # p candface, candx, candy
        if @cube[candface][candy][candx] == '.'
            return Tuple.new({candface, candx, candy}, canddir)
        else
            return {pn, dir}
        end
    end
end

class Part2
    property input : Input(P2Map)

    def initialize(file : String, example)
        @input = Input(P2Map).new(file, example)
    end

    def run()
        puts input.m.str
        curPn = input.m.startP
        curDir = :right
        i = 0
        input.r.each do |dist, rot|
            puts "#{curPn} #{curDir} #{dist} #{rot}"
            dist.times do
                curPn, curDir = input.m.checkMove(curPn, curDir)
                input.m.mark(curPn, curDir)
                # p curPn, curDir
                # puts input.m.str
            end
            curDir = P2Map.rotate(curDir, rot)
            # puts " #{curPn} #{curDir}"
            # p curPn, curDir
            i += 1
            # break if i == 4
        end

        puts "#{i} moves completed"
        input.m.mark(curPn, curDir, true)

        puts input.m.str
        
        numSym = {
            left: 2,
            right: 0,
            up: 3,
            down: 1
        }

        p flatY = curPn[2]+1 + input.m.cubeInOrigin[curPn[0]][1]
        p flatX = curPn[1]+1 + input.m.cubeInOrigin[curPn[0]][0]
        p numSym[curDir]
        (1000*(flatY) + 4*(flatX) + numSym[curDir]).to_s
    end
end

#36221
#104185