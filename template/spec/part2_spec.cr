require "spec"
require "../src/*"

root = "./"
day = "template"

describe day do
    describe "Part2" do
        it "example test case" do
            p1 = Part2.new(root + "/" + day + "/input/example.txt")
            p1.run.should eq("")
        end
    end
    describe "Part2 solution" do
        pending "part2 input" do
            p2 = Part2.new(root + "/" + day + "/input/input.txt")
            result = p2.run
            Spec.after_suite { p! result}
        end
    end
end