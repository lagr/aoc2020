input = File.read("#{__DIR__}/input.txt")

# Part 1
puts input.split("\n\n").sum {|group| group.chars.reject('\n').uniq.size }

# Part 2
puts input.split("\n\n").sum {|group|
  group.split('\n', remove_empty: true).map(&.chars).reduce {|group, member| group & member }.size
}
