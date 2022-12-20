class BiLinkedNode
    property prev : BiLinkedNode?
    property nxt : BiLinkedNode?
    property host : Node?

    def initialize()
    end

    def validate
        if !(pv = prev) || !(nx = nxt) || !(ht = host)
            raise "Bad validation"
        end
        {pv, nx, ht}
    end

    def insertAfter(nn : BiLinkedNode)
        pv, nx, _ = validate

        nn.nxt = nx
        nn.prev = self
        @nxt = nn
        nx.prev = nn
        nn.validate
    end

    def insertBefore(nn : BiLinkedNode)
        pv, nx, _ = validate

        nn.nxt = self
        nn.prev = pv
        @prev = nn
        pv.nxt = nn
        nn.validate
    end

    def remove
        pv, nx, _ = validate

        pv.nxt = nx
        nx.prev = pv
        @prev = nil
        @nxt = nil
        pv.validate
        nx.validate
    end

    def self.moveForwards(n : BiLinkedNode)
        pv, nx, _ = n.validate
        nx
    end

    def self.moveBackwards(n : BiLinkedNode)
        pv, nx, _ = n.validate
        pv
    end

    def self.moveN(n : BiLinkedNode, count : Int64, maxLen : Int64)
        pv, nx, _ = n.validate

        if count > 0
            dir = :forwards
        elsif count < 0
            count = count.abs()
            dir = :backwards
        else
            return
        end

        return if (count = count % (maxLen - 1)) == 0
        
        nn = n
        while count > 0
            case dir
            when :forwards
                nn = BiLinkedNode.moveForwards(nn)
            when
                nn = BiLinkedNode.moveBackwards(nn)
            end
            count -= 1
        end
        
        n.remove
        case dir
        when :forwards
            nn.insertAfter(n)
        when :backwards
            nn.insertBefore(n)
        end
    end

    def self.getN(n : BiLinkedNode, count : Int32)
        nn = n
        while count > 0
            nn = BiLinkedNode.moveForwards(nn)
            count -= 1
        end
        nn
    end
end