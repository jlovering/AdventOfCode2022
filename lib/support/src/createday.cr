require "file_utils"
require "./AoCSpecifics"

class CreateDay
    include AoCSpecifics

    getter day : Int32
    
    def initialize(@day : Int32)
    end

    private def day_path : Path
        Path.new(Dir.current, AOC_CALENDAR_ROOT, AOC_DAY_STRING % {day: day})
    end

    private def day_input_path : Path
        Path.new(day_path, AOC_INPUT_SUBPATH)
    end

    private def day_input_example : Path
        Path.new(day_input_path, AOC_INPUT_EXAMPLE)
    end

    private def day_src : Path
        Path.new(day_path, AOC_SRC_SUBPATH)
    end

    private def day_spec : Path
        Path.new(day_path, AOC_SPEC_SUBPATH)
    end

    private def template_path : Path
        Path.new(Dir.current, AOC_TEMPLATE)
    end

    private def template_src : Path
        Path.new(template_path, AOC_SRC_SUBPATH)
    end
    
    private def template_spec : Path
        Path.new(template_path, AOC_SPEC_SUBPATH)
    end

    def create_calendar
        unless Dir.exists? day_path.to_s
            Dir.mkdir_p(day_path)
        end

        unless Dir.exists? day_src
            FileUtils.cp_r(template_src, day_path)
        end

        unless Dir.exists? day_spec
            FileUtils.cp_r(template_spec, day_path)
        end

        unless Dir.exists? day_input_path
            Dir.mkdir_p(day_input_path)
        end

        unless File.exists? day_input_example
            FileUtils.touch(day_input_example)
        end
    end
end