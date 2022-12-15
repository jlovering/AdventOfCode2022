alias Point = Tuple(Int32, Int32)
alias SensorBeacon = Tuple(Point, Point)

class Input
    property sensors = [] of SensorBeacon

    def initialize(filename : String)
        File.each_line(filename) do |line|
            if (md = line.match(/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/))
                @sensors << SensorBeacon.new(Point.new(md[1].to_i, md[2].to_i), Point.new(md[3].to_i, md[4].to_i))
            end
        end
    end
end