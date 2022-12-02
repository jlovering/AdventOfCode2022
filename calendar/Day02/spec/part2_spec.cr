require "spec"
require "../src/*"
require "./spec_shared"
require "support/advent_of_code_client"

ds = DaySpec.new()
aoCc = AdventOfCodeClient.new(ds.dayNumber,2016)

describe ds.dayShortName do
    describe "Part2", tags: "part2" do
        it "example test case", tags: "example" do
            p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt")
            p1.run.should eq("12")
        end
        it "part2 solution", tags: "solution" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt")
            result = p2.run
            Spec.after_suite {
                puts "\nPart 2 result: #{result}"
            }
            if result != "" && ds.enableSubmit
                aoC_result = aoCc.submit_solution(ProblemPart::B, result)
                aoCc.flush
                aoC_result.should be_true
            end
        end
    end
end