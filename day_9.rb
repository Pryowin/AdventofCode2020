class XMASData
    def initialize(file,preamble_length)
        @data = Array.new
        File.open(file).each {|line| @data.push(line.to_i)}
        @preamble_length = preamble_length
    end

    def find_first_non_sum
       post_preamble = @data[@preamble_length..-1]
       post_preamble.each_with_index do |num,idx|
            return num unless sum_found(num,idx)
       end
       return -1
    end

    def sum_found(possible_sum,idx)
        numbers_to_check = @data[idx...idx + @preamble_length]
        numbers_to_check.each do |val|
            number_to_find = (possible_sum - val)
            return true if val != number_to_find && numbers_to_check.include?(number_to_find) 
        end
        return false
    end

    def get_conting(invalid_num)
        @data.each_with_index do |start_num,idx|
            min_val = start_num
            max_val = start_num
            if start_num < invalid_num
                sum = start_num
                @data[idx+1..-1 ].each do |num|
                    sum += num
                    min_val = [min_val,num].min
                    max_val = [max_val,num].max
                    return min_val + max_val if sum == invalid_num
                    break if sum > invalid_num
                end
            end
        end
        return 0
    end
end

test = false
file = "day_9_input.txt"
preamble_length = 25
if test
    file = "day_9_test_input.txt"
    preamble_length = 5
end
xd = XMASData.new(file,preamble_length)
invalid_num =  xd.find_first_non_sum
puts invalid_num
puts xd.get_conting(invalid_num)


    