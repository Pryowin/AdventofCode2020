require 'set'

class CustomsForm
    attr_reader :count
    def initialize(file)
        @count = 0
        answers = Set.new
        File.open(file).each do |line|
            line.strip!
            if line == ""
                @count += answers.length
                answers.clear
            else
                answers.merge(line.split(""))
            end
        end
        @count += answers.length
    end

    def showforms
        @forms.each {|form| puts form}
    end
end

cf = CustomsForm.new("day_6_input.txt")
puts cf.count