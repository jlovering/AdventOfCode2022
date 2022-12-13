class ListyList
    getter v : Int32
    getter listV : Array(ListyList)
    getter has_v : Bool
    getter has_l : Bool
    getter isNil : Bool

    def initialize(val : ListyList|Int32|Nil)
        @v = -1
        @listV = Array(ListyList).new()
        @has_v = false
        @has_l = false
        @isNil = true

        if val
            add_value(val)
        end
    end

    def add_value(val : Int32)
        if has_v
            @listV = [ListyList.new(v), ListyList.new(val)]
            @v = -1
            @has_v = false
            @has_l = true
        elsif has_l
            @listV << ListyList.new(val)
        else
            @v = val
            @has_v = true
            @has_l = false
        end
        @isNil = false
    end

    def add_value(val : ListyList)
        if has_v
            @listV = [ListyList.new(v), val]
            @v = -1
            @has_v = false
            @has_l = true
        elsif has_l
            @listV << val
        else
            @listV = [val]
            @v = -1
            @has_v = false
            @has_l = true
        end
        @isNil = false
    end

    def has_v?
        has_v
    end

    def has_l?
        has_l
    end

    def is_nil?
        @isNil
    end

    def <=>(other : ListyList)
        # p "#{self.to_s} <=> #{other.to_s}"

        if is_nil?
            return -1
        elsif !is_nil? && other.is_nil?
            return 1
        end
        if (has_v? && other.has_v?)
            if v < other.v
                return -1
            elsif v == other.v
                return 0
            else
                return 1
            end 
        elsif has_v? && other.has_l?
            return ListyList.new(self) <=> other
        elsif has_l? && other.has_v?
            return self <=> ListyList.new(other)
        else
            t1_itr = listV.each
            t2_itr = other.listV.each
            itr = t1_itr.zip(t2_itr)
            itr.each do |vl, vr|
                c = (vl <=> vr)
                if (c < 0)
                    return -1
                elsif (c > 0)
                    return 1
                end
            end
            if itr.next == Iterator::Stop::INSTANCE && listV.size < other.listV.size
                return -1 #we ran out of items first
            elsif itr.next == Iterator::Stop::INSTANCE && listV.size == other.listV.size
                return 0 #list are equal and all items are equal
            else
                return 1 #they ran out of items (wrong order)
            end
        end      
    end

    def to_s
        if has_v?
            "#{v}"
        elsif has_l?
            "[" + listV.map { |v| v.to_s.as(String) }.join(",") + "]"
        else
            ""
        end
    end
end

class Input

    getter listyLists : Array(Tuple(ListyList, ListyList))

    def self.parsePacket(pckt : String) : ListyList
        root = ListyList.new(nil)
        stack = Array(ListyList).new()
        stack << root
        curChar = [] of Char
        pckt.chars[1..-1].each do |c|
            case c
            when '['
                n = ListyList.new(nil)
                stack.last.add_value(n)
                stack << n
            when ']'
                if curChar.size > 0
                    stack.last.add_value(ListyList.new(curChar.join().to_i))
                    curChar = [] of Char
                end
                stack.pop()
            when .ascii_number?
                curChar << c
            when ','
                if curChar.size > 0
                    stack.last.add_value(ListyList.new(curChar.join().to_i))
                    curChar = [] of Char
                end
            end
        end
        root
    end

    def initialize(filename : String)
        packetPairs = File.read(filename).split("\n\n")
        lL = packetPairs.map do |l|
            p1, p2 = l.split("\n")
            {Input.parsePacket(p1), Input.parsePacket(p2)}
        end
        if !(@listyLists = lL)
            raise "Got a Nil, shoot me now"
        end
    end
end