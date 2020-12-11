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

    def count_arrangements(debug)
        arrangements = Array.new
        jolt_with_outlet = @joltages.unshift(0)
        jolt_with_outlet[1..-1].each do |jolt|
            cnt = 0
            cnt +=1 if jolt_with_outlet.include?(jolt-1)
            cnt +=1 if jolt_with_outlet.include?(jolt-2)
            cnt +=1 if jolt_with_outlet.include?(jolt-3)
            puts "#{jolt} - #{cnt}"
            arrangements.push(cnt) 
        end
        return calc_perm(arrangements,debug)
    end

    def calc_perm(arrangements,debug)
        idx =0
        total = 0
        perms = 1
        arrangements.each do |count|
            if count == 1 && perms > 1
                puts perms
                total += perms
                perms =1
            end
            if count > 1
                perms = perms * count
            end
        end
        total
    end
end

test = true
debug = false 
inp = "day_10_input.txt"
inp = "day_10_test_input.txt" if test


ad = Adapters.new(inp)
puts ad.build_chain(false)
puts ad.count_arrangements(debug)