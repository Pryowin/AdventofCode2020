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

end

test = false
file = "day_9_input.txt"
preamble_length = 25
if test
    file = "day_9_test_input.txt"
    preamble_length = 5
end
xd = XMASData.new(file,preamble_length)
puts xd.find_first_non_sum

    