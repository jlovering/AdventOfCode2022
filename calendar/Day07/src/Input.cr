require "./ntree.cr"

class Input
    property dirs : Ntree

    def initialize(filename : String)
        all_input = File.read_lines(filename)

        @dirs = Ntree.new("/", 0, nil, :dir)
        cur = dirs
        all_input.each do |line|
            # p line
            case line
                when /\$ ls/
                    # p "ls"
                    # do nothing
                when /\$ cd \//
                    # p "cd /"
                    cur = dirs
                when /\$ cd \.\./
                    # p "cd .."
                    if (md = line.match(/\$ cd (.+)/))
                        if (c = cur.parent)
                            cur = c
                        else
                            cur = dirs
                        end
                        # puts dirs.to_s + "\n"
                    else
                        raise "cd bad up"
                    end
                when /\$ cd .*/
                    # p "cd"
                    if (md = line.match(/\$ cd (.+)/))
                        cur = cur.find_child(md[1])
                        # puts dirs.to_s + "\n"
                    else
                        raise "cd to unknown dir"
                    end
                when /\d+ .+/
                    # p "file"
                    if (md = line.match(/(\d+) (.+)/))
                        cur.addChild(Ntree.new(md[2], md[1].to_i, cur, :file))
                        # p dirs
                        # puts dirs.to_s + "\n"
                    else
                        raise "bad child file"
                    end
                when /dir .+/
                    # p "dir"
                    if (md = line.match(/dir (.+)/))
                        cur.addChild(Ntree.new(md[1], 0, cur, :dir))
                        # puts dirs.to_s + "\n"
                    else
                        raise "bad child dir"
                    end
            end
        end
        puts dirs.to_s + "\n"
    end
end