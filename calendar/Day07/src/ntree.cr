class Ntree
    getter child = [] of Ntree
    getter name : String
    getter fssize : Int32
    getter parent : Ntree?

    getter subsize : Int32
    getter type : Symbol

    def initialize(@name, @fssize, @parent, @type)
        @subsize = 0
    end

    def addChild(c : Ntree)
        @child << c
        compute_subsize
    end

    def compute_subsize
        @subsize = child.reduce 0 { |acc, c| acc + c.fssize + c.subsize}
        if (p = @parent)
            p.compute_subsize
        end
    end

    def get_subsizes
        sses = [] of Int32
        sses << subsize
        child.each do |c| 
            sses = sses + c.get_subsizes
        end
        sses
    end

    def find_child(name : String) : Ntree
        child.select { |c| c.name == name }.first
    end

    def to_s
        return "#{name} #{fssize} #{subsize}" if child.size == 0
        "#{name} #{fssize} #{subsize}\n" + child.map { |c| name + "/" + c.to_s }.join("\n")
    end
end