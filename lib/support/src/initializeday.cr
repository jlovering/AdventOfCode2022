require "./createday"
require "./input_data"
require "option_parser"

day = 0
wait = false

OptionParser.parse do |parser|
    parser.banner = "Usage: initializeday.cr [arguemtns]"
    parser.on("-d DAY", "--day=DAY", "Specify the day") { |name| day = name.to_i}
    parser.on("-w", "--wait", "Wait for Santa") { wait = true}
    parser.on("-w", "--wait", "Wait for Santa") { wait = true}
end

if day == 0
    day = Time.local.day
end

CreateDay.new(day+1).create_calendar

if wait
    now = Time.local
    start = Time.local(now.year, now.month, day, 23, 0, 0)
    time_to_start = start - now
    if time_to_start > Time::Span.new(nanoseconds: 0)
        puts "You're early sleeping for #{time_to_start}"
        sleep(time_to_start)
    else
        puts "You're late hope to it!"
    end
end

InputData.new(day+1).input