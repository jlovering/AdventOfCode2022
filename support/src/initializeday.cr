require "./createday"
require "./input_data"

raise ArgumentError.new() unless ARGV.size == 1

CreateDay.new(ARGV[0].to_i).create_calendar
InputData.new(ARGV[0].to_i).input