require "spec"
require "../src/*"
require "./spec_shared"
require "../../../support/src/advent_of_code_client"

ds = DaySpec.new()
aoCc = AdventOfCodeClient.new(ds.dayNumber,2016)

describe ds.dayShortName do
    describe "Part2", tags: "part2" do
        it "example test case", tags: "example" do
            p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt")
            p1.run.should eq("foo")
        end
        it "part2 solution", tags: "solution" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt")
            result = p2.run
            if result != ""
                aoC_result = aoCc.submit_solution(ProblemPart::B, result)
                aoCc.flush
                aoC_result.should be_true
            else
                false.should be_true
            end
        end
    end
end