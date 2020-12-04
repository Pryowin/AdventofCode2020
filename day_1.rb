class ExpenseReport
    attr_reader :expenses
    def initialize(file)
      lines = IO.readlines(file)
      @expenses = lines.map{|line| line.to_i}.sort
    end
end

def get_answer
    report = ExpenseReport.new("day_1_input.txt")
    report.expenses.each do |exp|
        return exp * (2020-exp) if report.expenses.include?(2020-exp)
    end
end

def get_answer_part2
    report = ExpenseReport.new("day_1_input.txt")
    report.expenses.each do |exp1|
        report.expenses.each do |exp2|
            report.expenses.each do |exp3|
                if exp1 != exp2 && exp1 != exp3 && exp2 != exp3
                    return (exp1 * exp2 * exp3) if exp1 + exp2 + exp3 == 2020
                end
            end
        end
    end
end


puts get_answer_part2
