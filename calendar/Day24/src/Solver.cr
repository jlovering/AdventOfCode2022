class Solver
    def self.cross(startp : Point, endp : Point, g : Grid, simulate = true)        
        positionQueue = Array(Tuple(Point, Int32, Array(Point))).new()
        nextQueue = Array(Tuple(Point, Int32, Array(Point))).new()
        positionQueue << {startp, 0, [startp]}
        loop do
            g.simulate_next if simulate
            simulate = true
            while positionQueue.size > 0
                curPoint, count, path = positionQueue.shift
                # p "#{curPoint}, #{count}"
                
                return count if curPoint == endp
                # if curPoint == g.homeP
                #     puts "#{count} #{path}"
                #     return count.to_s
                # end

                Moves.each do |_, mv|
                    dx, dy = mv
                    candp = {curPoint[0] + dx, curPoint[1] + dy}
                    # p " #{candp}"
                    if g.p_can_move?(candp)
                        # p "  move good"
                        nextQueue << {candp, count+1, path + [candp]}
                    end
                end
            
                if !g.has_storm?(curPoint)
                    nextQueue << {curPoint, count+1, path + [curPoint]}
                end
            end

            positionQueue = nextQueue.uniq do |v|
                v[0]
            end

            nextQueue = Array(Tuple(Point, Int32, Array(Point))).new()
            # p positionQueue[0], positionQueue[-1], positionQueue.size
            # puts g.to_s
            raise "No solution possible" if positionQueue.size == 0
        end
    end
end