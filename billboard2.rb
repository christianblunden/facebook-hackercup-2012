def font_for(line)
  words_orig = line.split(' ').reverse
  width, height = [words_orig.pop.to_i, words_orig.pop.to_i]
  for font_size in 1..[width,height].max do
    max_rows, max_cols, rows, cols = [width/font_size, height/font_size, 1, 0]
    words = words_orig.map{|w| w}
    while !words.empty? do
      word_length = words.pop.length
      return (font_size-1) if word_length > max_cols # too wide
      rows, cols = [rows+1, 0] if cols + word_length > max_cols #new line needed
      return (font_size-1) if rows > max_rows # too tall
      cols += word_length
      next #word
    end  
  end
end

def main
  input = File.readlines('billboard_example.txt')
  #input = File.readlines('billboards.txt')
  
  File.open('billboard_output.txt', 'w') do |output|  
    for count in 1..input[0].to_i
      output.puts "Case #{count}: #{font_for(input[count])}"
    end
  end
end

main()