fibo = [0, 1]

while (current = fibo[-1] + fibo[-2]) <= 100
  fibo << current
end

puts fibo
