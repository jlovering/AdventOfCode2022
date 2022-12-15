require "./Input.cr"

class Part1
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def manhattanD(s : Point, b : Point)
        (s[0] - b[0]).abs + (s[1] - b[1]).abs
    end

    def generateAllPoint(s : Point, mD : Int32, l : Int32)
        points = Set(Point).new()
        points.add(s)
        (0..mD).each do |dy|
            if (s[1]+dy == l || s[1]-dy == l)
                xR = mD - dy
                (0..xR).each do |dx|
                    points.add(Point.new(s[0]+dx, s[1]+dy))
                    points.add(Point.new(s[0]+dx, s[1]-dy))
                    points.add(Point.new(s[0]-dx, s[1]+dy))
                    points.add(Point.new(s[0]-dx, s[1]-dy))
                end
            end
        end
        points
    end

    def findOnLine(y : Int32, excluded : Set(Point))
        count = 0
        excluded.each do |point|
            if point[1] == y
                count += 1
            end
        end
        count
    end

    def run(line)
        excluded = Set(Point).new()
        input.sensors.each do |s, b|
            mD = manhattanD(s, b)
            excluded += generateAllPoint(s, mD, line)
        end
        input.sensors.each do |s, b|
            excluded.delete(b)
        end
        findOnLine(line, excluded).to_s
    end
end