
Instruction = Struct.new(:opcode, :arg)
BootReturn = Struct.new(:accumulator, :instruction_number)

class Handheld

    def initialize(file)
      @boot_code =  IO.readlines(file)
      @length_of_boot = @boot_code.length
    end

    def boot(debug)
        accumulator = 0
        instruction_number = 0
        executed = Array.new(@boot_code.length + 1,false)
        executed[-1] = true
        until executed[instruction_number] do
            executed[instruction_number] = true
            instruction = decode(@boot_code[instruction_number])
            puts "#{instruction_number} is #{instruction[:opcode]} #{instruction[:arg]}" if debug
            case instruction[:opcode]
            when 'nop'
                instruction_number += 1
            when 'acc'
                instruction_number += 1
                accumulator += instruction[:arg]
            when 'jmp'
                instruction_number += instruction[:arg]
            end
        end
        boot_return = BootReturn.new
        boot_return[:accumulator] =accumulator
        boot_return[:instruction_number] = instruction_number
        return boot_return
    end

    def fix_code(debug)
        @boot_code.each_with_index do |instruction,idx|
            opcode = decode(instruction)[:opcode]
            unless opcode == "acc"
                if opcode == "nop"
                    @boot_code[idx][0...3] = "jmp"
                else
                    @boot_code[idx][0...3] = "nop"
                end
                result = boot(debug)
                return result[:accumulator] if result[:instruction_number] == @length_of_boot
                @boot_code[idx][0...3] = opcode
            end
        end
    end

    def decode(instruction)
        retval = Instruction.new
        parts = instruction.split(' ')
        retval[:opcode] = parts[0]
        retval[:arg] = parts[1].to_i
        return retval
    end

end

test = false
debug = false
inp = "day_8_input.txt"
inp = "day_8_test_input.txt" if test

hh = Handheld.new(inp)
puts hh.boot(debug)[:accumulator]
puts hh.fix_code(debug)