require "spec"
require "../src/*"
require "./spec_shared"
require "support/advent_of_code_client"

ds = DaySpec.new()
aoCc = AdventOfCodeClient.new(ds.dayNumber,2017)

describe ds.dayShortName do
    describe "Part1", tags: "part1" do
        it "example test case", tags: "example" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/example.txt")
            p1.run.should eq("foo")
        end
        it "part1 solution", tags: "solution" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/input.txt")
            result = p1.run
            if result != ""
                aoC_result = aoCc.submit_solution(ProblemPart::A, result)
                aoCc.flush
                aoC_result.should be_true
            else
                false.should be_true
            end
        end
    end
end