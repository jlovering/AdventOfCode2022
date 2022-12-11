class Monkey
    getter name : String
    @items : Array(Int64)
    @multfact : Int32
    @addfact : Int32
    @square : Bool
    getter testdiv : Int32
    @trueThrow : Int32
    @falseThrow : Int32
    getter inspections : Int32
    property worryReduction = 3
    @worryMethod = Symbol

    def initialize(mktext : String, monkeyies : Array(Monkey), @worryMethod = :intdiv)
        @name = ""
        @items = Array(Int64).new()
        @multfact = 0
        @addfact = 0
        @square = false
        @testdiv = 1
        @trueThrow = 0
        @falseThrow = 0
        @inspections = 0
        @monkeyies = monkeyies
        mktext.split("\n").each do |l|
            case l
                when /Monkey (\d+):/
                    @name = $~[1]
                when /\s*Starting items: (.*)$/
                    @items = $~[1].split(", ").map(&.to_i64)
                when /\s*Operation: new = old \* (\d+)$/
                    @multfact = $~[1].to_i
                when /\s*Operation: new = old \+ (\d+)$/
                    @addfact = $~[1].to_i
                when /\s*Operation: new = old \* old$/
                    @square = true
                when /\s*Test: divisible by (\d+)$/
                    @testdiv = $~[1].to_i
                when /\s*If true: throw to monkey (\d+)$/
                    @trueThrow = $~[1].to_i
                when /\s*If false: throw to monkey (\d+)$/
                    @falseThrow = $~[1].to_i
                else
                    raise "What is this monkey business? #{l}"
            end
        end
    end

    def monkeyAround
        @items.each do |i|
            # pp i
            monkeyInspect(i)
        end
        @items = [] of Int64
    end

    def increaseWorry(item : Int64) : Int64
        if @multfact != 0
            return item * @multfact
        elsif @addfact != 0
            return item + @addfact
        elsif @square
            return item * item
        else
            raise "Monkey is confused"
        end
    end

    def monkeyInspect(item)
        @inspections += 1
        item = increaseWorry(item)
        item = reduceWorry(item)
        throw(item)
    end

    def reduceWorry(item) : Int64
        case @worryMethod
        when :intdiv
            item // @worryReduction
        when :mod
            item % @worryReduction
        else
            raise "Bad worry reduction method!"
        end
    end

    def monkeyTest?(item) : Bool
        # pp "#{@name} #{item} #{@testdiv}"
        (item % @testdiv) == 0
    end

    def throw(item)
        if monkeyTest?(item)
            @monkeyies[@trueThrow].catch(item)
        else
            @monkeyies[@falseThrow].catch(item)
        end
    end

    def catch(item)
        @items << item
        # pp "#{@name} #{item} #{@items}"
    end

    def to_s
        "Monkey #{@name}: #{@items}"
    end
end