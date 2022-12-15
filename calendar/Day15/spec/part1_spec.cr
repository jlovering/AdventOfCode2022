require "spec"
require "../src/*"
require "./spec_shared"
require "support/advent_of_code_client"

ds = DaySpec.new()
aoCc = AdventOfCodeClient.new(ds.dayNumber,2017)

describe ds.dayShortName do
    describe "Part1", tags: "part1" do
        it "simple test case", tags: "example" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/simple.txt")
            p1.run(7).should eq("19")
        end
        it "simple test case", tags: "example" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/simple.txt")
            p1.run(8).should eq("17")
        end
        it "example test case", tags: "example" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/example.txt")
            p1.run(10).should eq("26")
        end
        it "part1 solution submit", tags: ["solution", "submit"] do
            p1 = Part1.new(ds.dayPath.to_s + "/input/input.txt")
            result = p1.run(2000000)
            Spec.after_suite {
                puts "\nPart 1 result: #{result}"
            }
            if result != "" && ds.enableSubmit
                aoC_result = aoCc.submit_solution(ProblemPart::A, result)
                aoCc.flush
                aoC_result.should be_true
            end
        end
    end
end