require "./Input.cr"

class Part2
    property input : Input

    def initialize(file : String)
        @input = Input.new(file)
    end

    def manhattanD(s : Point, b : Point)
        (s[0] - b[0]).abs + (s[1] - b[1]).abs
    end

    def sensorSkip(s : Point, smD : Int32, tp : Point) : Int32
        dx = smD - (tp[1] - s[1]).abs
        (s[0] - tp[0]) + dx + 1
    end

    def run(bound)
        found = nil
        x = 0
        y = 0
        
        hams = input.sensors.map do |s, b|
            {manhattanD(s, b), s}
        end.sort.reverse

        while y < bound
            while x < bound
                tp = Point.new(x,y)
                jmp = 1
                notFound = false

                hams.each do |smD, s|
                    if smD < manhattanD(s, tp)
                        notFound &= false
                    else
                        jmp = sensorSkip(s, smD, tp)
                        if jmp <= 0
                            jmp = 1
                        end
                        notFound = true
                        break
                    end
                end
                
                if !notFound
                    found = tp
                    break
                end
                x += jmp
            end
            if found
                break
            end
            x = 0
            y += 1
        end

        if (found)
            (Int64.new((found[0])) * 4000000 + found[1]).to_s
        else
            raise "You're kidding me right?!"
        end
    end
end