require "./Input.cr"

class Part2
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
        
        elves.sort.reverse[0..2].sum.to_s
    end
end