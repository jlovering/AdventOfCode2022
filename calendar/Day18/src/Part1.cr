require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def run()
        surfaces = Set(Tuple(Point, Symbol)).new()
        input.cubes.each do |c|
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