# This is the solution for Parts 1 and 2

file_path = File.expand_path("../inventory-management-system-input.txt", __FILE__)
input     = File.read(file_path)

input_array = input.split("\n")

sequences_with_twos = 0
sequences_with_threes = 0

input_array.each do |sequence|
  results = Hash.new(0)

  sequence.chars.each do |letter|
    results[letter] += 1
  end

  sequences_with_twos += 1 if results.has_value?(2)
  sequences_with_threes += 1 if results.has_value?(3)
end

puts sequences_with_twos * sequences_with_threes

# borrowed this from Stack Overflow
def levenshtein_distance(s, t)
  m = s.length
  n = t.length
  return m if n == 0
  return n if m == 0
  d = Array.new(m+1) {Array.new(n+1)}

  (0..m).each {|i| d[i][0] = i}
  (0..n).each {|j| d[0][j] = j}
  (1..n).each do |j|
    (1..m).each do |i|
      d[i][j] = if s[i-1] == t[j-1]  # adjust index into string
                  d[i-1][j-1]       # no operation required
                else
                  [ d[i-1][j]+1,    # deletion
                    d[i][j-1]+1,    # insertion
                    d[i-1][j-1]+1,  # substitution
                  ].min
                end
    end
  end
  d[m][n]
end

i = 0
distance_of_one = []

while i < input_array.length
  y = i + 1
  while y < input_array.length
    distance_of_one += [input_array[i], input_array[y]] if levenshtein_distance(input_array[i], input_array[y]) == 1
    y += 1
  end
  i += 1
end

sequence_one, sequence_two = distance_of_one[0], distance_of_one[1]

sequence_one.slice!((sequence_one.chars.each_with_index.to_a - sequence_two.chars.each_with_index.to_a).join.slice(1).to_i)

puts sequence_one
