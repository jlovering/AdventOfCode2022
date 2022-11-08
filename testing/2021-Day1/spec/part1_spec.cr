require "spec"
require "../src/*"

day = "Day1"

describe day do
    describe "Part1" do
        it "example test case" do
            p1 = Part1.new("calendar/" + day + "/input/part1_example.io")
            p1.run.should eq(7)
        end
    end
    describe "Part1 solution" do
        it "part1 input" do
            p1 = Part1.new("calendar/" + day + "/input/part1.io")
            result = p1.run
            Spec.after_suite { p! result}
        end
    end
end