HACKERCUP = "HACKERCUP".each_char.map{|c| c}
def count_for(characters)
  counts = Hash.new(0)
  characters.each{|c| 
    counts[c] += 1 if HACKERCUP.include?(c) 
  }
  return 0 if counts.length < 8
  counts["C"] = (counts["C"]/2).floor
  return counts.values.min
end

def main
  output = File.open('alphabet_output.txt', 'w')
  lines = File.readlines('alphabet_soup.txt')
  count = lines[0].to_i
  for i in 1..count do
    characters = lines[i].each_char
    output.puts("Case ##{i}: #{count_for(characters)}")
  end
end

main()