require "spec"
require "../src/*"
require "./spec_shared"
require "support/advent_of_code_client"

ds = DaySpec.new()
aoCc = AdventOfCodeClient.new(ds.dayNumber,2016)

describe ds.dayShortName do
    describe "Sanity", tags: "sanity" do
        # it "movement from a", tags: "sanity" do
        #     p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt", true)
        #     p1.input.m.offFaceMove({:a,3,0}, :right).should eq(Tuple.new({:f,3,3}, :left))
        #     # p1.input.m.offFaceMove({:a,3,3}, :down).should eq(Tuple.new({:d,3,0}, :down))
        #     # p1.input.m.offFaceMove({:a,0,3}, :left).should eq(Tuple.new({:c,0,3}, :down))
        #     # p1.input.m.offFaceMove({:a,0,0}, :up).should eq(Tuple.new({:b,0,0}, :down))
        # end
        # it "movement to a", tags: "sanity" do
        #     p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt", true)
        #     p1.input.m.offFaceMove({:f,3,3}, :right).should eq(Tuple.new({:a,3,0}, :left))
        #     # p1.input.m.offFaceMove({:d,3,3}, :up).should eq(Tuple.new({:a,3,0}, :up))
        #     # p1.input.m.offFaceMove({:c,0,3}, :up).should eq(Tuple.new({:a,0,3}, :right))
        #     # p1.input.m.offFaceMove({:b,3,3}, :up).should eq(Tuple.new({:a,0,3}, :down))
        # end
        # it "movement from e", tags: "sanity" do
        #     p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt", true)
        #     # p1.input.m.offFaceMove({:e,3,3}, :up).should eq(Tuple.new({:d,3,0}, :up))
        #     p1.input.m.offFaceMove({:e,3,3}, :right).should eq(Tuple.new({:f,0,3}, :right))
        #     # p1.input.m.offFaceMove({:e,0,0}, :down).should eq(Tuple.new({:b,3,0}, :up))
        #     p1.input.m.offFaceMove({:e,0,0}, :left).should eq(Tuple.new({:c,0,0}, :up))
        # end
        # it "movement to e", tags: "sanity" do
        #     p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt", true)
        #     # p1.input.m.offFaceMove({:d,3,0}, :down).should eq(Tuple.new({:e,3,3}, :down))
        #     p1.input.m.offFaceMove({:f,0,3}, :left).should eq(Tuple.new({:e,3,3}, :left))
        #     # p1.input.m.offFaceMove({:b,3,0}, :down).should eq(Tuple.new({:e,0,0}, :up))
        #     # p1.input.m.offFaceMove({:c,0,0}, :down).should eq(Tuple.new({:e,0,0}, :right))
        # end
        # it "movement to/from d", tags: "sanity" do
        #     p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt", true)
        #     # p1.input.m.offFaceMove({:d,3,0}, :right).should eq(Tuple.new({:f,0,3}, :down))
        #     p1.input.m.offFaceMove({:d,0,3}, :left).should eq(Tuple.new({:c,3,3}, :left))
        #     # p1.input.m.offFaceMove({:f,0,3}, :up).should eq(Tuple.new({:d,3,0}, :left))
        #     p1.input.m.offFaceMove({:c,3,3}, :right).should eq(Tuple.new({:d,0,3}, :right))
        # end
        # it "movement to/from b", tags: "sanity" do
        #     p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt", true)
        #     p1.input.m.offFaceMove({:b,3,0}, :right).should eq(Tuple.new({:c,0,0}, :right))
        #     p1.input.m.offFaceMove({:b,0,3}, :left).should eq(Tuple.new({:f,3,0}, :up))
            
        #     p1.input.m.offFaceMove({:f,3,0}, :down).should eq(Tuple.new({:b,0,3}, :right))
        #     p1.input.m.offFaceMove({:c,0,0}, :left).should eq(Tuple.new({:b,3,0}, :left))
        # end

        it "movement from c", tags: "sanity" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt", false)
            p2.input.m.offFaceMove({:c,10,0}, :up).should eq(Tuple.new({:a,10,49}, :up))
            p2.input.m.offFaceMove({:c,10,49}, :down).should eq(Tuple.new({:d,10,0}, :down))
            p2.input.m.offFaceMove({:c,49,10}, :right).should eq(Tuple.new({:b,10,49}, :up))
            p2.input.m.offFaceMove({:c,0,10}, :left).should eq(Tuple.new({:e,10,0}, :down))
        end
        it "movement to c", tags: "sanity" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt", false)
            p2.input.m.offFaceMove({:a,10,49}, :down).should eq(Tuple.new({:c,10,0}, :down))
            p2.input.m.offFaceMove({:d,10,0}, :up).should eq(Tuple.new({:c,10,49}, :up))
            p2.input.m.offFaceMove({:b,10,49}, :down).should eq(Tuple.new({:c,49,10}, :left))
            p2.input.m.offFaceMove({:e,10,0}, :up).should eq(Tuple.new({:c,0,10}, :right))
        end
        it "movement from f", tags: "sanity" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt", false)
            p2.input.m.offFaceMove({:f,10,0}, :up).should eq(Tuple.new({:e,10,49}, :up))
            p2.input.m.offFaceMove({:f,10,49}, :down).should eq(Tuple.new({:b,10,0}, :down))
            p2.input.m.offFaceMove({:f,49,10}, :right).should eq(Tuple.new({:d,10,49}, :up))
            p2.input.m.offFaceMove({:f,0,10}, :left).should eq(Tuple.new({:a,10,0}, :down))
        end
        it "movement to f", tags: "sanity" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt", false)
            p2.input.m.offFaceMove({:e,10,49}, :down).should eq(Tuple.new({:f,10,0}, :down))
            p2.input.m.offFaceMove({:b,10,0}, :up).should eq(Tuple.new({:f,10,49}, :up))
            p2.input.m.offFaceMove({:d,10,49}, :down).should eq(Tuple.new({:f,49,10}, :left))
            p2.input.m.offFaceMove({:a,10,0}, :up).should eq(Tuple.new({:f,0,10}, :right))
        end
        it "movement to/from d", tags: "sanity" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt", false)
            p2.input.m.offFaceMove({:d,0,10}, :left).should eq(Tuple.new({:e,49,10}, :left))
            p2.input.m.offFaceMove({:e,49,10}, :right).should eq(Tuple.new({:d,0,10}, :right))

            p2.input.m.offFaceMove({:d,49,10}, :right).should eq(Tuple.new({:b,49,39}, :left))
            p2.input.m.offFaceMove({:b,49,39}, :right).should eq(Tuple.new({:d,49,10}, :left))
        end
        it "movement to/from a", tags: "sanity" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt", false)
            p2.input.m.offFaceMove({:a,49,10}, :right).should eq(Tuple.new({:b,0,10}, :right))
            p2.input.m.offFaceMove({:b,0,10}, :left).should eq(Tuple.new({:a,49,10}, :left))

            p2.input.m.offFaceMove({:a,0,10}, :left).should eq(Tuple.new({:e,0,39}, :right))
            p2.input.m.offFaceMove({:e,0,39}, :left).should eq(Tuple.new({:a,0,10}, :right))
        end
    end
    describe "Part2", tags: "part2" do
        it "example test case", tags: "example" do
            p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt", true)
            p1.run.should eq("5031")
        end
        it "part2 solution", tags: "solution" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt", false)
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
        it "Tim part2 solution", tags: "solution" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/timput.txt", false)
            result = p2.run
            Spec.after_suite {
                puts "\nTim Part 2 result: #{result}"
            }
            if result != "" && ds.enableSubmit
                aoC_result = aoCc.submit_solution(ProblemPart::B, result)
                aoCc.flush
                aoC_result.should be_true
            end
        end
    end
end