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
  
  return child_lines.uniq
end

def combinations_for(billboard)
  combinations = [billboard[:text]]
  combinations.concat children(combinations)
end

def max_font_for(line)
  puts line.inspect 
  return 1
end

def required_font_size_for(billboard)
  return 0 if too_narrow(billboard)
  foo = combinations_for(billboard).map{|line| max_font_for(line)}
  
  return 1
end

def main
  input = File.open('example_input.txt')
  output = File.open('output.txt', 'w')
  
  expected_billboards = input.gets
  count = 1
  while(!input.eof?) do
    billboard = get_billboard(input)
    font = required_font_size_for(billboard)
    puts "Case #{count}: #{font}"
    count += 1
  end
end

main()