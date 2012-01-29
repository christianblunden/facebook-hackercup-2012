MEM = {}
def fact(x)
  return MEM[x] if MEM[x]
  result = (2..x).inject(1) { |f,n| f*n }
  MEM[x] = result
  result
end

def number_of_paths(m,n)
  min = [m,n].min
  max = [m,n].max
  return 0 if max == 0
  return 1 if min == 0
  return fact(m+n) / (fact(m) * fact(n))
end

def invalid(x,y,m,n)
  return true if x==0 and y==0
  return true if x==m and y==n
  return true if m > n
  return false
end

def shortest_path_for(distinct_path_count)
  puts fact(20).to_i
  puts ff(20).to_i
  raise
  puts "DISTINCT PATHS:#{distinct_path_count}"
  max_grid = [100].max
  solutions = []
  (0..max_grid).each do |m|
    (0..max_grid).each do |n|
      (0..m).each do |x|
        (0..n).each do |y|
          next if invalid(x,y,m,n)
          paths_to_checkpoint = number_of_paths(x,y)
          next if paths_to_checkpoint > distinct_path_count
          paths_to_goal = number_of_paths(m-x, n-y)
          next unless (paths_to_checkpoint*paths_to_goal) == distinct_path_count
          solutions << m+n
          next
        end
      end
    end
  end
  solutions.min
end

def main
  
  input = File.readlines('checkpoint_example.txt')
  #input = File.readlines('checkpoints.txt')
  
  File.open('checkpoint_output.txt', 'w') do |output|  
    for count in 1..input[0].to_i
      output.puts "Case #{count}: #{shortest_path_for(input[count].to_i)}"
    end
  end
end

main()