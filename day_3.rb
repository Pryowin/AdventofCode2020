class Map

    TREE = "#"

    def initialize(file)
        @rows = IO.readlines(file)
        @row_count = @rows.length
        @col_count = @rows[0].length-1
    end

    def has_tree(x,y)
        puts "x=#{x} (#{x % @col_count}), y=#{y} : #{@rows[y][x % @col_count]}" 
        return true if @rows[y][x % @col_count] == TREE
        return false
    end

    def at_bottom(y)
        return true if y >= @row_count
    end
end

class Travel
    def initialize(file, dx,dy)
        @map = Map.new(file)
        @dx = dx
        @dy = dy
    end

    def trees
        count = 0
        x = 0 
        y = 0
        loop do 
            x += @dx
            y += @dy
            return count if @map.at_bottom(y)
            count += 1 if @map.has_tree(x,y)
        end
    end
end

tree_count = 1
moves =[[1,1],[3,1],[5,1],[7,1],[1,2]]
moves.each do |move|
    route = Travel.new("day_3_input.txt",move[0],move[1])
    tree_count = tree_count * route.trees
end
puts tree_count

