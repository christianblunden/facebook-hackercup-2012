# encoding: UTF-8

def get_billboard(input)
  line = input.gets
  matches = line.match(/(\d+)\s(\d+)\s([0-9a-zA-Z ]+)/)
  {width:matches[1].to_i, height:matches[2].to_i, text:matches[3].strip}
end

def too_narrow(billboard)
  words = billboard[:text].split(' ')
  longest_word = words.sort_by(&:length).last
  return longest_word.length > billboard[:width]
end

def join(words)
  words.join(' ')
end

def new_line(index, head, tail)
  new_line = []
  new_line.concat(head) if head
  return { line:new_line.concat( [join(tail[0..index]), join(tail[(index+1)..-1])] ) }
end

def children(line)
  tail = line.last.split(' ')
  return [] if tail.length == 1

  child_lines = []
  head = line[0..(line.length-2)] if line.length > 1
  for i in 0..tail.length-1
    child_lines << new_line(i, head, tail)
    child_lines.concat children(child_lines.last[:line])
  end
  
  return child_lines.map{|l| { line:l[:line].reject(&:empty?) } }
end

def combinations_for(billboard)
  combinations = [{line:[billboard[:text]]}]
  combinations.concat(children([billboard[:text]]))
end

def max_font_for(data, billboard)
  display = data[:line]
  max_columns = display.map{|line| line.length}.max
  max_font_by_width = billboard[:width] / max_columns
  max_font_by_height = billboard[:height] / display.length
  
  return [max_font_by_height,max_font_by_width].min
end

def required_font_size_for(billboard)
  return 0 if too_narrow(billboard)
  return combinations_for(billboard).map{|line| max_font_for(line, billboard)}.max
end

def main
  input = File.open('billboards.txt')
  output = File.open('output.txt', 'w')
  
  expected_billboards = input.gets
  count = 1
  while(!input.eof?) do
    font = required_font_size_for(get_billboard(input))
    output.write "Case #{count}: #{font}"
    count += 1
  end
  
  output.close
end

main()