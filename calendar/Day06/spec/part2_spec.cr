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
            p1.run.should eq("19")
        end
        it "example test case 2", tags: "example" do
            p1 = Part2.new(ds.dayPath.to_s + "/input/example1.txt")
            p1.run.should eq("23")
        end
        it "example test case 3", tags: "example" do
            p1 = Part2.new(ds.dayPath.to_s + "/input/example2.txt")
            p1.run.should eq("23")
        end
        it "example test case 4", tags: "example" do
            p1 = Part2.new(ds.dayPath.to_s + "/input/example3.txt")
            p1.run.should eq("29")
        end
        it "example test case 5", tags: "example" do
            p1 = Part2.new(ds.dayPath.to_s + "/input/example4.txt")
            p1.run.should eq("26")
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