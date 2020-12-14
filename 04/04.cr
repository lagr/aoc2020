input = File.read("#{__DIR__}/input.txt")

struct Passport
  property  byr : String, iyr : String, eyr : String, hgt : String,
            hcl : String, ecl : String, pid : String, cid : String

  def initialize(raw)
    @byr, @iyr, @eyr, @hgt, @hcl, @ecl, @pid, @cid = [
      raw["byr"]?, raw["iyr"]?, raw["eyr"]?, raw["hgt"]?,
      raw["hcl"]?, raw["ecl"]?, raw["pid"]?, raw["cid"]?
    ].map(&.to_s)
  end

  def valid?
    [byr, iyr, eyr, hgt, hcl, ecl, pid].none?(&.blank?) &&
      byr.in?("1920".."2002") &&
      iyr.in?("2010".."2020") &&
      eyr.in?("2020".."2030") &&
      ecl.in?(%w(amb blu brn gry grn hzl oth)) &&
      hgt.matches?(/^(1[5-8][0-9]cm|19[0-3]cm|59in|6[0-9]in|7[0-6]in)$/) &&
      hcl.matches?(/^#[0-9a-f]{6}$/) &&
      pid.matches?(/^\d{9}$/)
  end
end

passports = input.split("\n\n").map do |entry|
  raw = entry.split(/[\s\n]/, remove_empty: true).map{ |field| field.split(':') }.to_h
  Passport.new(raw)
end

puts passports.count(&.valid?)
