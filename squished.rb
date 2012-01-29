MOD = 4207849484

def invalid?(message, max_int)
  return true if message[0].to_i == 0
  return message.each_char.any?{|c| c.to_i > max_int}
end

def end_of(message)
  return true if message.nil?
  return message.empty?
end

def message_count(max_int, message)
  return 1 if end_of(message)
  return 0 if invalid?(message, max_int)
  
  number = ""
  branches = 0
  message[0..(max_int.to_s.length-1)].each_char do |c|
    if (number+c).to_i <= max_int
      number += c 
      rest_of_message = message[number.length..-1]
      branches += 1 * message_count(max_int, rest_of_message)
    end
  end
  
  return branches
end

def main
  input = File.open('squished_example.txt')
  #input = File.readlines('squished.txt')
  
  File.open('squished_output.txt', 'w') do |output|  
    for count in 1..input.gets.to_i
      m,message = input.gets.split(/\W/)
      message = input.gets if message.nil?
      output.puts "Case #{count}: #{message_count(m.to_i,message.strip) % MOD}"
    end
  end
end

main()