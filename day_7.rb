require 'set'

BagCount = Struct.new(:color, :count)

class Suitcase
    BAGS = "bags"
    BAG = "bag"
    CONTAIN = "contain"
    NO_CONTAIN = "no other bags."

    attr_reader :contains, :contained_in, :contains_with_count

    def initialize(file)
        @contains = Hash.new
        @contained_in =Hash.new
        @contains_with_count = Hash.new

        File.open(file).each do |line|
            container = get_container(line)
            contained = get_contained(line.strip,false)
            contained_with_count = get_contained(line.strip,true)
            @contains[container] = contained
            @contains_with_count[container] = contained_with_count
            contained.each do |bag|
                @contained_in[bag] = [] unless @contained_in.has_key?(bag)
                @contained_in[bag].push(container)
            end
        end
    end

    private

    def get_container(line)
        idx = line.index(BAGS)
        line[0...idx-1]
    end

    def get_contained(line,need_numbers)
        idx = line.index(CONTAIN)
        idx += CONTAIN.length + 1 
        contained = []
        return contained if line[idx..-1] == NO_CONTAIN
        bags = line[idx..-1].split(",")
        bags.each do |bag|
            count = bag.scan(/\d+/).first.to_i
            bag.gsub!(/\d+/,"")
            bag.gsub!(BAGS,"")
            bag.gsub!(BAG,"")
            bag.gsub!(".","")
            bag.strip!
            if need_numbers
                contained.push(BagCount.new(bag,count))
            else
                contained.push(bag)
            end
            
        end
        return contained
    end

end

class Containers
    
    def initialize(contained_in)
        @contained_in = contained_in
        @containers_list = Set.new
    end

    def list_immediate_containers(bag_color)
        return [] unless @contained_in.has_key?(bag_color)
        return @contained_in[bag_color]
    end
    

    def list_all_containers(bag_color)
        list_containers(list_immediate_containers(bag_color))
    end

    def list_containers(bag_list)
        bag_list.each do |bag|
            @containers_list.add(bag)
            contained_by = list_immediate_containers(bag)
            if contained_by.length > 1
               list_containers(contained_by)
            else
                @containers_list.add(contained_by.to_s) unless contained_by.empty?
            end
        end
    end

    def count_containers
        return @containers_list.length
    end

end

class Contains
    attr_reader :count
    def initialize(contains_with_count)
        @contains_with_count = contains_with_count
    end


    def count_bags_in_top_level(color)
        @count = 0
        count_bags_in(@contains_with_count[color],1)
    end

    def count_bags_in(bags,qty)
        bags.each do |bag|
            color_qty = qty * bag[:count]
            @count += color_qty
            bags_in_bag = @contains_with_count[bag[:color]] 
            count_bags_in(bags_in_bag, color_qty) if bags_in_bag.length > 0
        end
    end
end



sc = Suitcase.new("day_7_input.txt")
# puts sc.contains_with_count["dark olive"][0][:color]
# containers = Containers.new(sc.contained_in)
# containers.list_all_containers("shiny gold")
# puts containers.count_containers
con = Contains.new(sc.contains_with_count)
con.count_bags_in_top_level("shiny gold")
puts con.count
