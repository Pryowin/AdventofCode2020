require './day_4'

describe "Passport" do
    before(:all) do
        @passport = Passport.new("day_4_rspec_input.txt")
    end

    describe "#byr_valid?" do
        it "is valid if birth year is 1965" do
            expect(@passport.byr_valid?(@passport.passports[0])).to eq true
        end  
        it "is invalid if birth year is 1900" do
            expect(@passport.byr_valid?(@passport.passports[1])).to eq false
        end  
        it "is invalid if birth year is 2019" do
            expect(@passport.byr_valid?(@passport.passports[2])).to eq false
        end  
        it "is invalid if birth year is not numeric" do
            expect(@passport.byr_valid?(@passport.passports[3])).to eq false
        end  
    end
    describe "#iyr_valid" do
        it "is valid if issue year is 2010" do
            expect(@passport.iyr_valid?(@passport.passports[0])).to eq true
        end  
        it "is invalid if issue year is 2009" do
            expect(@passport.iyr_valid?(@passport.passports[1])).to eq false
        end  
        it "is invalid if issue year is 2021" do
            expect(@passport.iyr_valid?(@passport.passports[2])).to eq false
        end  
        it "is invalid if issue year is not numeric" do
            expect(@passport.iyr_valid?(@passport.passports[3])).to eq false
        end  
    end
    describe "#eyr_valid" do
        it "is valid if expiry year is 2020" do
            expect(@passport.eyr_valid?(@passport.passports[0])).to eq true
        end  
        it "is invalid if expiry year is 2019" do
            expect(@passport.eyr_valid?(@passport.passports[1])).to eq false
        end  
        it "is invalid if expiry year is 2031" do
            expect(@passport.eyr_valid?(@passport.passports[2])).to eq false
        end  
        it "is invalid if issue expiry is not numeric" do
            expect(@passport.eyr_valid?(@passport.passports[3])).to eq false
        end  
    end
    describe "#hgt_valid" do
        it "is valid if height is 60in" do
            expect(@passport.hgt_valid?(@passport.passports[0])).to eq true
        end
        it "is valid if height is 183cm" do
            expect(@passport.hgt_valid?(@passport.passports[1])).to eq true
        end
        it "is invalid if height is 183" do
            expect(@passport.hgt_valid?(@passport.passports[2])).to eq false
        end
        it "is invalid if height is 183in" do
            expect(@passport.hgt_valid?(@passport.passports[3])).to eq false
        end
    end
    describe "#hcl_valid" do
        it "is valid if hair color is #fffffd" do
            expect(@passport.hcl_valid?(@passport.passports[0])).to eq true
        end
        it "is invalid if hair color is fffffdd" do
            expect(@passport.hcl_valid?(@passport.passports[1])).to eq false
        end
        it "is invalid if hair color is #123abg" do
            expect(@passport.hcl_valid?(@passport.passports[2])).to eq false
        end
        it "is invalid if hair color is #fffffdd" do
            expect(@passport.hcl_valid?(@passport.passports[3])).to eq false
        end
    end
    describe "#ecl_valid" do
        it "is valid if eye color is gry" do
            expect(@passport.ecl_valid?(@passport.passports[0])).to eq true
        end
        it "is valid if eye color is xxx" do
            expect(@passport.ecl_valid?(@passport.passports[1])).to eq false
        end
    end
    describe "#pid_valid" do
        it "is valid if pid is 860033327" do
            expect(@passport.pid_valid?(@passport.passports[0])).to eq true
        end
        it "is valid if pid is 8600333279" do
            expect(@passport.pid_valid?(@passport.passports[1])).to eq false
        end
        it "is valid if pid is 86003332" do
            expect(@passport.pid_valid?(@passport.passports[2])).to eq false
        end
    end
    

end
