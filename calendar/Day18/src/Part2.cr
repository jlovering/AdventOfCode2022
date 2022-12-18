require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def bounds(i)
        {input.cubes.min_by { |c| c[i] }[i] - 1, input.cubes.max_by { |c| c[i] }[i] + 1}
    end

    def checkBounds(v, min, max)
        v >= min && v <= max
    end

    def run()
        xmin, xmax = bounds(0)
        ymin, ymax = bounds(1)
        zmin, zmax = bounds(2)

        mutations = [
            {1,0,0},
            {-1,0,0},
            {0,1,0},
            {0,-1,0},
            {0,0,1},
            {0,0,-1}]

        water = Set(Point).new()
        stack = Array(Point).new()
        stack << {xmin, ymin, zmin}
        while stack.size != 0
            pn = stack.pop
            if water.includes?(pn)
                next
            end
            
            water.add(pn)

            mutations.each do |dx, dy, dz| 
                nPn = {pn[0] + dx, pn[1] + dy, pn[2] + dz}
                if checkBounds(nPn[0], xmin, xmax) &&
                    checkBounds(nPn[1], ymin, ymax) &&
                    checkBounds(nPn[2], zmin, zmax) && 
                    !input.cubes.includes?(nPn)
                    stack << nPn
                end
            end
        end

        newCubes = Set(Point).new()
        (xmin..xmax).each do |x|
            (ymin..ymax).each do |y|
                (zmin..zmax).each do |z|
                    nC = {x, y, z}
                    if !water.includes?(nC)
                        newCubes.add(nC)
                    end
                end
            end
        end

        surfaces = Set(Tuple(Point, Symbol)).new()
        newCubes.each do |c|
            cX = {c[0]+1, c[1], c[2]}
            cY = {c[0], c[1]+1, c[2]}
            cZ = {c[0], c[1], c[2]+1}
            cS = Set(Tuple(Point, Symbol)).new()
            [{c, :x},
            {cX, :x},
            {c, :y},
            {cY, :y},
            {c, :z},
            {cZ, :z}].each do |s|
                cS.add(s)
            end
            da = cS - surfaces
            db = surfaces - cS
            surfaces = da | db
            # p surfaces
        end

        surfaces.size.to_s
    end
end