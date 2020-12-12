input = File.read_lines("#{__DIR__}/input.txt")

pattern_length = input.first.size

# Part 1
puts input.map_with_index {|line, index| line.char_at((index * 3) % pattern_length) }.count('#')

# Part 2
slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]

result = slopes.map do |(right, down)|
  samples = input.map_with_index do |line, index|
    next if index % down != 0
    position = ((index / down) * right).to_i
    line.char_at(position % pattern_length)
  end

  samples.count('#')
end

puts result.product(1.to_i64)
