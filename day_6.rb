require 'set'

class CustomsForm
    attr_reader :count, :everyone_count
    def initialize(file)
        @count = 0
        @everyone_count =0
        person_in_group_cnt = 0
        answers = Hash.new
        File.open(file).each do |line|
            line.strip!
            if line == ""
                @everyone_count += find_everyone_yes(answers, person_in_group_cnt)
                @count += answers.length
                person_in_group_cnt = 0
                answers.clear
            else
                answers = parse_answers(answers, line)
                person_in_group_cnt += 1 
            end
        end
        @count += answers.length
        @everyone_count += find_everyone_yes(answers, person_in_group_cnt)
    end

    def showforms
        @forms.each {|form| puts form}
    end

    def find_everyone_yes(answers, count)
        ret = 0
        answers.each {|key,value|  ret += 1 if value == count }
        return ret
    end

    def parse_answers(answers, line)
        line.split("").each do |reply|
            if answers.has_key?(reply)
                answers[reply] += 1
            else
                answers[reply] = 1
            end
        end
        return answers
    end
end

cf = CustomsForm.new("day_6_input.txt")
puts cf.count
puts cf.everyone_count