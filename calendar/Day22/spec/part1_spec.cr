require "spec"
require "../src/*"
require "./spec_shared"
require "support/advent_of_code_client"

ds = DaySpec.new()
aoCc = AdventOfCodeClient.new(ds.dayNumber,2017)

describe ds.dayShortName do
    describe "Map Functions", tags: "ihml" do
        it "basic map movement on example", tags: "ihml" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/examplemod.txt")
            p1.input.m.checkMove({4,5}, :right).should eq({5,5})
            p1.input.m.checkMove({4,5}, :left).should eq({3,5})
            p1.input.m.checkMove({4,5}, :up).should eq({4,4})
            p1.input.m.checkMove({4,5}, :down).should eq({4,6})
        end
        it "blocked map movement on example", tags: "ihml" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/examplemod.txt")
            p1.input.m.checkMove({10,0}, :right).should eq({10,0})
            p1.input.m.checkMove({9,2}, :left).should eq({9,2})
            p1.input.m.checkMove({9,2}, :up).should eq({9,2})
            p1.input.m.checkMove({11,7}, :left).should eq({11,7})
            p1.input.m.checkMove({11,7}, :down).should eq({11,7})
        end
        it "bad start map movement on example", tags: "ihml" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/examplemod.txt")
            expect_raises(Exception) do
                p1.input.m.checkMove({11,0}, :right)
            end
        end
        it "looped map movement on example", tags: "ihml" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/examplemod.txt")
            p1.input.m.checkMove({8,0}, :up).should eq({8,11})
            p1.input.m.checkMove({8,11}, :down).should eq({8,0})
            
            p1.input.m.checkMove({7,4}, :up).should eq({7,7})
            p1.input.m.checkMove({7,7}, :down).should eq({7,4})

            p1.input.m.checkMove({14,9}, :up).should eq({14,10})
            p1.input.m.checkMove({14,10}, :down).should eq({14,9})
            
            p1.input.m.checkMove({11,3}, :right).should eq({8,3})
            p1.input.m.checkMove({8,3}, :left).should eq({11,3})

            p1.input.m.checkMove({0,5}, :left).should eq({11,5})
            p1.input.m.checkMove({11,5}, :right).should eq({0,5})
        end
        it "loop blocked map movement on example", tags: "ihml" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/examplemod.txt")
            p1.input.m.checkMove({8,0}, :left).should eq({8,0})
            p1.input.m.checkMove({11,2}, :right).should eq({11,2})
            p1.input.m.checkMove({3,7}, :down).should eq({3,7})
            p1.input.m.checkMove({13,10}, :down).should eq({13,10})
            p1.input.m.checkMove({15,9}, :down).should eq({15,9})
        end
    end
    describe "Part1", tags: "part1" do
        it "example test case", tags: "example" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/example.txt")
            p1.run.should eq("6032")
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
        it "tim part1 solution submit", tags: ["solution", "submit"] do
            p1 = Part1.new(ds.dayPath.to_s + "/input/timput.txt")
            result = p1.run
            Spec.after_suite {
                puts "\nTim Part 1 result: #{result}"
            }
            if result != "" && ds.enableSubmit
                aoC_result = aoCc.submit_solution(ProblemPart::A, result)
                aoCc.flush
                aoC_result.should be_true
            end
        end
    end
end