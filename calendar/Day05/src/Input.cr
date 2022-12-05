class Input
    property stacks = Hash(String, Array(Char)).new
    property moves = [] of Tuple(Int32, String, String)

    def initialize(filename : String)
        bulk = File.read(filename)
        stacks_r, moves_r = bulk.split(/\n\n/).map(&.split(/\n/))

        stack_names = stacks_r.last.chars.map_with_index { |n, i| ((i-1) % 4 == 0) ? n : nil }.compact
        stack_names.each {|n| @stacks[n.to_s] = [] of Char}
        
        stacks_r[..-2].reverse.each do |l|
            l.chars.map_with_index { |n, i| ((i-1) % 4 == 0) ? n : nil }.compact.each_with_index do |crate, i|
                @stacks[stack_names[i].to_s] << crate if crate != ' '
            end
        end
        
        moves_r.map do |l|
            if (md = l.match(/move ([0-9]+) from ([0-9]+) to ([0-9]+)/))
                @moves << {md[1].to_i, md[2], md[3]}
            end
        end
    end
end