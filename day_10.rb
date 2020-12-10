class Adapters
    def initialize(file)
        @joltages = Array.new
        File.open(file).each {|line| @joltages.push(line.to_i)}
        @joltages.sort!
    end

    def build_chain(debug)
        count_of_3 = 0
        count_of_1 = 0
        last_joltage = 0
        @joltages.each do |jolt|
            diff = jolt - last_joltage
            
            count_of_3 += 1 if diff == 3
            count_of_1 += 1 if diff == 1
            puts "#{jolt} : #{diff} count of 1 = #{count_of_1} count of 3 = #{count_of_3}" if debug
            last_joltage = jolt
        end
        count_of_3 += 1
        return count_of_1 * count_of_3
    end
end

test = false
debug = false
inp = "day_10_input.txt"
inp = "day_10_test_input.txt" if test


ad = Adapters.new(inp)
puts ad.build_chain(debug)