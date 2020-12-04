require './day_2/Password'

class ReadAndValidate
    attr_reader :valid_count

    def initialize(file,policy)
      @pwd_file = lines = IO.readlines(file)
      @valid_count = 0
      @policy = policy
    end

    def validate_lines
        @pwd_file.each do |line|
            pwd = Password.new(line)
            @valid_count +=1 if pwd.is_valid(@policy) 
        end
    end

end


puts "Policy 1"
pwd_list = ReadAndValidate.new('input_day_2.txt',1)
pwd_list.validate_lines
puts pwd_list.valid_count
puts "Policy 2"
pwd_list = ReadAndValidate.new('input_day_2.txt',2)
pwd_list.validate_lines
puts pwd_list.valid_count