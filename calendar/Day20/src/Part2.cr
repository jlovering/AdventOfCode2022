require "./Input.cr"

class Part2
    property input : Input

    getter magicHash = Hash(Int32, Node).new()

    def initialize(file : String)
        @input = Input.new(file)
    end

    def dumpNodes(which, dir=:forwards)
        starting_node = magicHash[0]
        node = magicHash[0]
        values = [] of Int64
        loop do
            values << node.value
            
            case {which, dir}
            when {:org, :forwards}
                break if !(nx = node.orgList.nxt)
            when {:org, :backwards}
                break if !(nx = node.orgList.prev)
            when {:new, :forwards}
                break if !(nx = node.newList.nxt)
            when {:new, :backwards}
                break if !(nx = node.newList.prev)
            else
                raise "Shucks!"
            end
            break if !(node = nx.host)
            break if node == starting_node
        end

        values
    end

    def find(value : Int32)
        @magicHash.each do |k,v|
            if v.value == value
                return k
            end
        end
        raise "No find"
    end

    def run()
        nodes = input.numbs.map_with_index do |v, i|
            Node.new(Int64.new(v) * 811589153, BiLinkedNode.new(), BiLinkedNode.new())
        end

        @magicHash = nodes.map_with_index do |n, i|
            n.orgList.prev = nodes[i-1].orgList
            n.orgList.nxt = nodes[(i + 1) % nodes.size].orgList
            n.orgList.host = n

            n.newList.prev = nodes[i-1].newList
            n.newList.nxt = nodes[(i + 1) % nodes.size].newList
            n.newList.host = n
            
            {i, n}
        end.to_h

        10.times do
            input.numbs.each_with_index do |v, i|
                BiLinkedNode.moveN(@magicHash[i].newList, Int64.new(v) * 811589153, @magicHash.size)
            end
        end
        
        zeroIndex = find(0)
        ns = [BiLinkedNode.getN(@magicHash[zeroIndex].newList, 1000).host, 
        BiLinkedNode.getN(@magicHash[zeroIndex].newList, 2000).host,
        BiLinkedNode.getN(@magicHash[zeroIndex].newList, 3000).host].compact.map(&.value)
        p ns
        ns.sum.to_s
    end
end