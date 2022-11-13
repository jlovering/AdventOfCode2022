require "./advent_of_code_client"
require "./AoCSpecifics"

class InputData
  include AoCSpecifics

  getter day : Int32
  getter year : Int32

  def initialize(day : Int32, year : Int32 = 2022)
    @day = day
    @year = year
  end

  def input
    return if cached?

    input = AdventOfCodeClient.new(day, year).get_input

    create_cache(input)
  end

  private def cached? : Bool
    File.exists? cache_file_path
  end

  private def read_cache : String
    File.read cache_file_path
  end

  private def cache_file_path : Path
    Path.new(Dir.current, AOC_CALENDAR_ROOT, AOC_DAY_STRING % {day: day}, AOC_INPUT_SUBPATH, AOC_INPUT_FILE_NAME)
  end

  private def create_cache(content : String)
    unless Dir.exists? cache_file_path.dirname
      Dir.mkdir_p(cache_file_path.dirname)
    end

    File.write(cache_file_path, content)
  end
end