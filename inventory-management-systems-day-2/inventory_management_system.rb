file_path = File.expand_path("../inventory-management-system-input.txt", __FILE__)
input     = File.read(file_path)

sequences_with_twos = 0
sequences_with_threes = 0

input.split("\n").each do |sequence|
  results = Hash.new(0)

  sequence.chars.each do |letter|
    results[letter] += 1
  end

  sequences_with_twos += 1 if results.has_value?(2)
  sequences_with_threes += 1 if results.has_value?(3)
end

puts sequences_with_twos * sequences_with_threes
