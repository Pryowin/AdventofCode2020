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
    end

    def follow_seating_rules(type, debug)
        @previous = []
        @round = 0
        until @previous == @seats do
            do_round(type,debug)
            show_state if debug
        end
        return @seats.flatten.select{|seat| seat==OCCUPIED}.count
    end

    def do_round(type,debug)
        @previous = @seats.clone.map(&:clone)
        @round += 1
        (0...@row_count).each do |y|
            (0...@column_count).each do |x|
                if type == 1
                    seats[y][x] = new_state_rule1(y,x,debug) unless @seats[y][x] == FLOOR
                else
                    seats[y][x] = new_state_rule2(y,x,debug) unless @seats[y][x] == FLOOR
                end
            end
        end
    end

    def new_state_rule1(y,x,debug)
        empty_cnt = 0
        (y-1..y+1).each do |yy|
            (x-1..x+1).each do |xx|
                if out_of_bounds(yy,xx)
                    empty_cnt += 1
                else
                    empty_cnt +=1 unless @previous[yy][xx] == OCCUPIED || (yy == y && xx == x)
                end
            end
        end
        return OCCUPIED if empty_cnt == 8
        return EMPTY if empty_cnt < 5
        return @previous[y][x]
    end

    def new_state_rule2(y,x,debug)
        full_cnt = 0
        (-1..+1).each do |dy|
            (-1..+1).each do |dx|
                unless (dx == 0 && dy == 0) 
                    full_cnt += 1 if seat_is_occupied(y,x,dy,dx)
                    puts "#{x},#{y} : #{full_cnt}" if debug && @round ==2 
                end
            end
        end
        return OCCUPIED if full_cnt == 0
        return EMPTY if full_cnt > 4
        return @previous[y][x]
    end

    def seat_is_occupied(y,x,dy,dx)
        chk_y = y + dy
        chk_x = x + dx
        obj = FLOOR
        
        until out_of_bounds(chk_x,chk_y) || @previous[chk_y][chk_x] != FLOOR do
            chk_y += dy
            chk_x += dx
        end
        return false if out_of_bounds(chk_x,chk_y)
        return true if  @previous[chk_y][chk_x] == OCCUPIED
        return false
    end

    def out_of_bounds(x,y)
        return true if x < 0 || x == @column_count
        return true if y < 0 || y == @row_count
        return false
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
puts lng.follow_seating_rules(2, debug)