input = File.read_lines("#{__DIR__}/input.txt")
            .map {|line| line.split(/[\s-:]/, remove_empty: true) }

# Part 1
puts input.count { |(min, max, char, pw)| (min.to_i..max.to_i).includes?(pw.count(char)) }

# Part 2
puts input.count { |(first, second, char, pw)|
  [first, second].map{|i| pw[i.to_i-1]?.to_s }.one?(char)
}
