input = File.read_lines("#{__DIR__}/input.txt")

struct Seat
  property seat_id : Int32

  def initialize(directions)
    @seat_id = directions.gsub({ F: 0, B: 1, L: 0, R: 1 }).to_i(base: 2)
  end

  def -(other : Seat)
    seat_id - other.seat_id
  end

  def <=>(other : Seat)
    seat_id <=> other.seat_id
  end

  def next_seat
    seat_id + 1
  end
end

seats = input.map(&->Seat.new(String))

# Part 1
puts seats.max.seat_id

# Part 2
puts seats.sort.each_cons_pair { |a, b| break a.next_seat if b - a == 2}
