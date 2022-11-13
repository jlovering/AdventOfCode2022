require "spec"
require "../src/*"

root = "./"
day = "template"

describe day do
    describe "Part1" do
        it "example test case" do
            p1 = Part1.new(root + "/" + day + "/input/example.txt")
            p1.run.should eq("")
        end
    end
    describe "Part1 solution" do
        pending "part1 input" do
            p1 = Part1.new(root + "/" + day + "/input/input.txt")
            result = p1.run
            Spec.after_suite { p! result}
        end
    end
end