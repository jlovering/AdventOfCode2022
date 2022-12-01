require "./Input.cr"

class Part1
    property input : String
    
    def initialize(file : String)
        @input = File.read(file)
    end

    def run()
        elves = input.split(/\n\n/).map { |elf| 
            elf.split(/\n/).map { |i|
                i.to_i
            }.sum
        }
        elves.max.to_s
    end
end