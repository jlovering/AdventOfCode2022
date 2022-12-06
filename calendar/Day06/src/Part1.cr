require "./Input.cr"

class Part1
    property input : String

    def initialize(file : String)
        @input = File.read(file).chomp
    end

    def check_unique?(b)
        b.to_set.size == 4
    end

    def run()
        buf = [] of Char
        input.chars.each_with_index do |c, i|
            buf << c
            if buf.size >= 4
                return (i+1).to_s if check_unique?(buf)
                buf.shift
            end
        end
        ""
    end
end