alias Point = Tuple(Int32, Int32)

class Input(T)
    property m : T
    property r = Array(Tuple(Int32, String)).new()

    def initialize(filename : String, example = false)
        mp, route = File.read(filename).split("\n\n")
        mi = [] of Array(Char)
        mp.split("\n").each do |line|
            mi << line.chars
        end

        @m = T.new(mi, example)

        route.scan(/(\d+)(\w)/).each do |sc|
            _, d, f = sc
            @r << {d.to_i, f}
        end
    end
end