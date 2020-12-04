class Password
    attr_reader :min, :max, :char, :password
    
    def initialize(line)
      @min = get_min(line)
      @max = get_max(line)
      @char = get_char(line)
      @password = get_pwd(line)
    end

    def get_min(line)
        pos = line.index('-')
        return line[0...pos].to_i
    end

    def get_max(line)
        start_pos = line.index('-')
        end_pos = line.index(' ')
        return line[start_pos+1...end_pos].to_i
    end

    def get_char(line)
        pos = line.index(' ')
        return line[pos+1]
    end

    def get_pwd(line)
        pos = line.index(':')
        return line[pos+2..-1]
    end
    
    def is_valid(policy)
        if policy == 1
            occur = @password.count(@char)
            return true if occur >= @min && occur <= @max
            return false
        else
            pos_count = 0
            pos_count +=1 if @password[@min-1] == @char
            pos_count +=1 if @password[@max-1] == @char
            return true if pos_count == 1
            false
        end
    end
end