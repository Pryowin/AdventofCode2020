require './day_2/Password'

describe Password do
    describe "#min" do
        it "finds one digit min" do
            password = Password.new("1-5 r: rlmrrr")
            expect(password.min).to eq(1)  
        end
        it "finds two digit min" do
            password = Password.new("11-21 r: rlmrrr")
            expect(password.min).to eq(11)  
        end
    end 
    describe "#max" do
        it "finds one digit max" do
            password = Password.new("1-5 r: rlmrrr")
            expect(password.max).to eq(5)  
        end
        it "finds one digit max" do
            password = Password.new("11-21 r: rlmrrr")
            expect(password.max).to eq(21)  
        end
    end
    describe "#char" do
        it "finds the character" do
            password = Password.new("12-20 m: mmmmmjmmcmdmmmmmcmmm")
            expect(password.char).to eq("m")
        end
    end
    describe "#password" do
        it "finds the password" do
            password = Password.new("12-20 m: mmmmmjmmcmdmmmmmcmmm")
            expect(password.password).to eq("mmmmmjmmcmdmmmmmcmmm")
        end
    end
    describe "#valid" do
        it "shows valid under policy 1" do
            password = Password.new("12-20 m: mmmmmjmmcmdmmmmmcmmm")
            expect(password.is_valid(1)).to eq(true)
        end
        it "shows invalid under policy 2" do
            password = Password.new("12-20 m: mmmmmjmmcmdmmmmmcmmm")
            expect(password.is_valid(2)).to eq(false)
        end
    end
end

