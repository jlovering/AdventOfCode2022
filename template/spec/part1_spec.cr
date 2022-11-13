require "spec"
require "../src/*"
require "./spec_shared"

ds = DaySpec.new()

describe ds.dayShortName do
    describe "Part1" do
        it "example test case" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/example.txt")
            p1.run.should eq("foo")
        end
        it "part1 solution" do
            p1 = Part1.new(ds.dayPath.to_s + "/input/input.txt")
            result = p1.run
            Spec.after_suite { p! result}
        end
    end
end