input = File.read_lines("#{__DIR__}/input.txt").map(&.to_i64)

# Part 1
def find_invalid_number(data)
  data.skip(25).each_cons(26) do |slice|
    number = slice.pop
    return number if slice.combinations(2).none?{|(a,b)| a + b == number }
  end
end

puts find_invalid_number(input)

# Part 2
def find_consecutive_numbers_that_sum_to_invalid_number(numbers)
  invalid_number = find_invalid_number(numbers)
  return if invalid_number.nil?

  numbers.each_with_index do |first_number_in_range, index|
    next if first_number_in_range >= invalid_number

    first_range_end = index + 1
    range = Array(Int64).new
    sum_of_range = 0

    (first_range_end..).each do |range_end|
      range = numbers[index..range_end]
      sum_of_range = range.sum
      break if sum_of_range >= invalid_number
    end

    return range.min + range.max if sum_of_range == invalid_number
  end
end

puts find_consecutive_numbers_that_sum_to_invalid_number(input)
