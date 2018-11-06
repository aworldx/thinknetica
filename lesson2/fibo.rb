fibo = [0, 1]

loop do
  current = fibo[-1] + fibo[-2]

  break if current > 100

  fibo << current
end

puts fibo
