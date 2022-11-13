require "spec"
require "../src/*"
require "./spec_shared"

ds = DaySpec.new()

describe ds.dayShortName do
    describe "Part2" do
        it "example test case" do
            p1 = Part2.new(ds.dayPath.to_s + "/input/example.txt")
            p1.run.should eq("foo")
        end
        it "part2 solution" do
            p2 = Part2.new(ds.dayPath.to_s + "/input/input.txt")
            result = p2.run
            Spec.after_suite { p! result}
        end
    end
end