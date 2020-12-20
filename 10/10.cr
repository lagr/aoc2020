adapters = File.read_lines("#{__DIR__}/input.txt").map(&.to_i).sort

output_joltage = 0
highest_adapter_joltage = adapters.last
consumer_device = highest_adapter_joltage + 3

device_chain = [output_joltage].concat(adapters).push(consumer_device)

# Part 1
puts device_chain.each_cons(2).map {|(a, b)| b - a }.tally.values.product

# Part 2
paths_to = device_chain.to_h {|device| {device, 0.to_i64} }
paths_to[0] = 1

device_chain.each do |device|
  (1..3).each do |joltage_difference|
    next_candidate = device + joltage_difference
    paths_to[next_candidate] += paths_to[device] if paths_to.has_key?(next_candidate)
  end
end

puts paths_to[consumer_device]
