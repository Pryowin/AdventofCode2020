require './day_7'

INP ="./day_7_test_input.txt"

describe "Suitcase" do
    before(:all) do
        @suitcase =  Suitcase.new(INP)
    end
    describe "#contains" do
        it "faded blue contains nothing" do
            expect(@suitcase.contains["faded blue"]).to eq []  
        end
        it "muted yellow  contains gold and blue" do
            expect(@suitcase.contains["muted yellow"]).to eq ["shiny gold", "faded blue"]  
        end
    end
    describe "#contained in" do
        it "vibrant plum is contained in shiny gold" do
            expect(@suitcase.contained_in["vibrant plum"]).to eq ["shiny gold"]
        end
        it "bright white is contained in red and orange" do
            expect(@suitcase.contained_in["bright white"]).to eq ["light red", "dark orange"]
        end
    end
    describe "#contains_with_count" do
        it "dark olive contains 3 faded blue and 4 dotted black" do
            expect(@suitcase.contains_with_count["dark olive"][0][:color]).to eq  "faded blue"
            expect(@suitcase.contains_with_count["dark olive"][0][:count]).to eq  3 
            expect(@suitcase.contains_with_count["dark olive"][1][:color]).to eq  "dotted black"
            expect(@suitcase.contains_with_count["dark olive"][1][:count]).to eq  4
        end
    end
end

describe "Containers" do
    before(:all) do
        @rules = Containers.new({"bright white"=>["light red", "dark orange"], "muted yellow"=>["light red"],"dark orange"=>["canary yellow"],"canary yellow"=>[]})
    end
    describe "#list_immediate_containers" do
        it "pink is contained in nothing as it does not exist" do
            expect(@rules.list_immediate_containers("pink")).to  eq []
        end
        it "canary yellow has no containers" do
            expect(@rules.list_immediate_containers("canary yellow")).to  eq []
        end
        it "muted yellow is contained in only red" do
            expect(@rules.list_immediate_containers("muted yellow")).to eq  ["light red"]
        end
        it "white is contained in red and orange" do
            expect(@rules.list_immediate_containers("bright white")).to eq  ["light red", "dark orange"]
        end
    end
    describe "#count_containers" do
        it "#bright white is in 3 containers" do
            @rules.list_all_containers("bright white")
            expect(@rules.count_containers).to eq 3
        end
    end
end

