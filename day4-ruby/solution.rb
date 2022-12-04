file = File.open("./input.txt")
data = file.read

lines = data.split(/\n/)

# part 1
def fully_contains?(pair)
  start_1, end_1 = pair[0].split(/-/).map { |n| Integer(n) }
  start_2, end_2 = pair[1].split(/-/).map { |n| Integer(n) }
  (start_1 >= start_2 and end_1 <= end_2) or 
  (start_1 <= start_2 and end_1 >= end_2)
end

pairs = lines.map { |line| line.split(/,/) }

total = pairs.reduce(0) { |sum, pair| fully_contains?(pair) ? sum + 1 : sum }
puts total

# part 2
def overlap?(pair)
  start_1, end_1 = pair[0].split(/-/).map { |n| Integer(n) }
  start_2, end_2 = pair[1].split(/-/).map { |n| Integer(n) }
  (start_1 <= start_2 and start_2 <= end_1) or
  (start_2 <= start_1 and start_1 <= end_2)
end

total = pairs.reduce(0) { |sum, pair| overlap?(pair) ? sum + 1 : sum }
puts total