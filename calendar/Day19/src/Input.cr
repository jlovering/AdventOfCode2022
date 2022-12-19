alias RoboRule = Array(Int32)

class Input
    property roboRules = [] of Tuple(RoboRule, RoboRule, RoboRule, RoboRule)

    def initialize(filename : String)
        File.each_line(filename) do |line|
            _, rules = line.split(": ")
            oreR, clayR, obsidianR, geodeR = rules.split(". ")
            o = [oreR.split(" ")[4].to_i, 0, 0, 0]
            c = [clayR.split(" ")[4].to_i, 0, 0, 0]
            obs = obsidianR.split(" ")
            ob = [obs[4].to_i, obs[7].to_i, 0, 0]
            geo = geodeR.split(" ")
            g = [geo[4].to_i, 0, geo[7].to_i, 0]
            roboRules << {g.reverse, ob.reverse, c.reverse, o.reverse}
        end
    end
end