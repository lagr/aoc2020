rules = File.read_lines("#{__DIR__}/input.txt")

class Bag
  class_property colors = Hash(String, self).new

  property containable_in_bags = Set(self).new

  def self.find_or_create(color)
    @@colors[color] ||= self.new
  end

  def self.apply_rule(rule)
    bag = /(?<color>\w+\s\w+) bags contain (?:(?<contained_bags>\d.*)|(?<contains_no_bags>no other bags))$/.match(rule)
    return if bag.nil? || bag["contains_no_bags"]?

    bag["contained_bags"].scan(/(?:(\d) (\w+\s\w+))/).each do |(_, amount, contained_color)|
      self.find_or_create(contained_color).containable_in(bag["color"])
    end
  end

  def containable_in(color)
    containable_in_bags << Bag.find_or_create(color)
  end

  def containing_bags
    containable_in_bags.dup.tap do |result|
      containable_in_bags.each {|bag| result.concat(bag.containing_bags) }
    end
  end
end

rules.map(&->Bag.apply_rule(String))

# Part 1
puts Bag.colors["shiny gold"].containing_bags.size
