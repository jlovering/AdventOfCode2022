require "spec"
require "../src/*"

day = "template"

describe day do
    describe "Part2" do
        it "example test case" do
            p1 = Part2.new("calendar/" + day + "/input/part2_example.io")
            p1.run.should eq("")
        end
    end
    describe "Part2 solution" do
        pending "part2 input" do
            p2 = Part2.new("calendar/" + day + "/input/part2.io")
            result = p2.run
            Spec.after_suite { p! result}
        end
    end
end