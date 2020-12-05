class BoardingPasses

    ROWS = 128
    SEATS = 8
    UPPER_CODE_ROWS = "B"
    UPPER_CODE_SEATS = "R"
    
    attr_reader :pass

    def initialize(file)
        @pass =[]
        @file =  IO.readlines(file)
        @file.each do |line|
            @pass.push(get_val(line.split("")))
        end
    end

    def get_val(line)
        
        row = binary_search(line[0..6], UPPER_CODE_ROWS, ROWS)
        seat = binary_search(line[7..-1], UPPER_CODE_SEATS, SEATS)
        return (row - 1) * 8 + (seat - 1)
    end

    def binary_search(code_line,upper,max_val)
        min = 1
        max = max_val
        code_line.each do |code|
            if code == upper
                min = min + adjust(max,min)
            else
                max = max - adjust(max,min)
            end 
            # puts "#{code} : #{min} - #{max}"
        end
        return min
    end

    def adjust(max,min)
        return (max - min + 1) / 2
    end
        

    def max_seat_id
        @pass.max
    end

    def find_empty_seat
        (1..918).each do |seat|
            unless @pass.include?(seat)
                return seat if @pass.include?(seat - 1) && @pass.include?(seat + 1)
            end
        end
        return -1 
    end
end

bp = BoardingPasses.new("day_5_input.txt")
puts bp.max_seat_id
puts bp.find_empty_seat
