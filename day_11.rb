class Lounge

    EMPTY = "L"
    OCCUPIED = "#"
    FLOOR = "."

    attr_reader :seats

    def initialize(file)
        @seats = Array.new
        File.open(file).each {|row| @seats.push(row.split'')}
        @row_count = @seats.size
        @column_count = @seats[0].size - 1
        @round = 0
    end

    def follow_seating_rules(debug)
        until @previous == @seats do
            do_round
            show_state if debug
        end
        return @seats.flatten.select{|seat| seat==OCCUPIED}.count
    end

    def do_round
        @previous = @seats.clone.map(&:clone)
        @round += 1
        (0...@row_count).each do |y|
            (0...@column_count).each do |x|
                @seats[y][x] = new_state(y,x) unless @seats[y][x] == FLOOR
            end
        end
    end

    def new_state(y,x)
        empty_cnt = 0
        (y-1..y+1).each do |yy|
            (x-1..x+1).each do |xx|
                if yy < 0 || yy == @row_count || xx < 0 || xx == @column_count
                    empty_cnt += 1
                else
                    empty_cnt +=1 unless @previous[yy][xx] == OCCUPIED || (yy == y && xx == x)
                end
            end
        end
        return OCCUPIED if empty_cnt == 8
        return EMPTY if empty_cnt < 5
        return @seats[y][x]
    end

    def show_state
        puts "Round = #{@round}"
        (0...@row_count).each do |y|
            (0...@column_count).each do |x|
                print @seats[y][x]
            end
            puts
        end
    end

end


test = false
debug = false 
inp = "day_11_input.txt"
inp = "day_11_test_input.txt" if test

lng=Lounge.new(inp)
puts lng.follow_seating_rules(debug)
