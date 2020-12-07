require 'set'

class Suitcase
    BAGS = "bags"
    BAG = "bag"
    CONTAIN = "contain"
    NO_CONTAIN = "no other bags."

    attr_reader :contains, :contained_in

    def initialize(file)
        @contains = Hash.new
        @contained_in =Hash.new
        File.open(file).each do |line|
            container = get_container(line)
            contained = get_contained(line.strip)
            @contains[container] = contained
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

    def get_contained(line)
        idx = line.index(CONTAIN)
        idx += CONTAIN.length + 1 
        contained = []
        return contained if line[idx..-1] == NO_CONTAIN
        bags = line[idx..-1].split(",")
        bags.each do |bag|
            bag.gsub!(/\d+/,"")
            bag.gsub!(BAGS,"")
            bag.gsub!(BAG,"")
            bag.gsub!(".","")
            bag.strip!
            contained.push(bag)
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


sc = Suitcase.new("day_7_input.txt")
containers = Containers.new(sc.contained_in)
containers.list_all_containers("shiny gold")
puts containers.count_containers