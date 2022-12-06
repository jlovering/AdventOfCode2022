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
            p1.run.should eq("7")
        end
        it "example test case 2", tags: "example" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/example1.txt")
            p1.run.should eq("5")
        end
        it "example test case 3", tags: "example" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/example2.txt")
            p1.run.should eq("6")
        end
        it "example test case 4", tags: "example" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/example3.txt")
            p1.run.should eq("10")
        end
        it "example test case 5", tags: "example" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/example4.txt")
            p1.run.should eq("11")
        end
        it "part1 solution submit", tags: ["solution", "submit"] do
            p1 = Part1.new(ds.dayPath.to_s + "/input/input.txt")
            result = p1.run
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