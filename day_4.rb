class Passport

    REQUIRED = ["byr:","iyr:","eyr:","hgt:","hcl:","ecl:","pid:"]
    EYE_COLORS = "amb blu brn gry grn hzl oth"

    attr_reader :passports

    def initialize(file)
        document = ""
        @passports = []
        File.open(file).each do |line|
            if line.strip == ""
                @passports.push(document)
                document = ""
            else    
                document += " " unless document == ""
                document += line
            end 
        end
        @passports.push(document)
    end

    def is_valid?(doc,ruleset)  
        return passes_full_validation?(doc) if ruleset == 2
        valid = true
        REQUIRED.each { |fld| valid = false unless doc.include? fld}
        return valid
    end

    def passes_full_validation?(doc)
        return false unless is_valid?(doc,1)
        return false unless byr_valid?(doc)
        return false unless eyr_valid?(doc)
        return false unless iyr_valid?(doc)
        return false unless hgt_valid?(doc)
        return false unless hcl_valid?(doc)
        return false unless ecl_valid?(doc)
        return false unless pid_valid?(doc)
        true
    end

    def byr_valid?(doc)
        idx = doc.index("byr:") + 4
        return false unless doc[idx..idx+4].to_i >= 1920 && doc[idx..idx+4].to_i <= 2002
        true
    end
    def iyr_valid?(doc)
        idx = doc.index("iyr:") + 4
        return false unless doc[idx..idx+4].to_i >= 2010 && doc[idx..idx+4].to_i <= 2020
        true
    end
    def eyr_valid?(doc)
        idx = doc.index("eyr:") + 4
        year = doc[idx..idx+4].to_i
        return true if year.between?(2020,2030)
        false
    end
    def hgt_valid?(doc)
        idx = doc.index("hgt:") + 4
        str = doc[idx..-1]
        unless /^\d\din/.match(str).nil?
            return true if str.to_i > 58 && str.to_i < 77
        end
        unless /^\d\d\dcm/.match(str).nil?
            return true if str.to_i > 149 && str.to_i < 194
        end
        return false
    end
    def hcl_valid?(doc)
        idx = doc.index("hcl:") + 4
        str = doc[idx..-1] + " "
        return true unless /^#[\d|[a-f]]{6}\s/.match(str).nil?
        false
    end
    def ecl_valid?(doc)
        idx = doc.index("ecl:") + 4
        return false if idx + 3 > doc.length
        str = doc[idx..idx+2]
        return true if EYE_COLORS.include? str
        false
    end
    def pid_valid?(doc)
        idx = doc.index("pid:") + 4
        str = doc[idx..-1]+" "
        return true unless /^\d{9}\s/.match(str).nil?
        return false
    end

    def valid_count(ruleset)
        count = 0
        @passports.each {|doc| count +=1 if is_valid?(doc,ruleset)}
        count
    end

    def document_count
        return @passports.count
    end

    def list_invalid(ruleset)
        @passports.each {|doc| puts "#{doc}\n" unless is_valid?(doc,ruleset)}
    end
    def list_valid(ruleset)
        @passports.each {|doc| puts "#{doc}\n" if is_valid?(doc,ruleset)}
    end
end



