input = File.read("#{__DIR__}/input.txt")

class Instruction
  property type : String
  property argument : Int32

  def initialize(raw_instruction)
    match = /(?<type>\w{3}) (?<argument>.+)$/.match(raw_instruction).not_nil!
    @type = match["type"]
    @argument = match["argument"].to_i
  end
end

class Program
  property instructions : Array(Instruction)

  def initialize(source_code)
    @instructions = source_code.lines.map(&->Instruction.new(String))
  end

  def run
    visited_instructions = Array(Int32).new
    instruction_addr = 0
    acc = 0

    while instruction = instructions[instruction_addr]?
      visited_instructions << instruction_addr

      case instruction.type
      when "jmp"
        instruction_addr += instruction.argument
      when "acc"
        acc += instruction.argument
        instruction_addr += 1
      when "nop"
        instruction_addr += 1
      end

      raise "Infinite loop detected @ acc=#{acc}" if instruction_addr.in?(visited_instructions)
    end

    acc
  end
end

# Part 1
begin
  Program.new(input).run
rescue ex : Exception
  puts ex.message
end

# Part 2
class Debugger
  property program : Program

  def initialize(@program); end

  def debug
    patch_instructions("jmp", "nop") || patch_instructions("nop", "jmp")
  end

  def patch_instructions(type, other_type)
    instructions_to_patch = program.instructions.select {|i| i.type == type }

    instructions_to_patch.each do |instruction|
      instruction.type = other_type
      result = program.run
    rescue
      instruction.type = type
    else
      return result
    end
  end
end

program = Program.new(input)
puts Debugger.new(program).debug
