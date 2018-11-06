fibo = [0, 1]
current = 1

while current <= 100
  fibo << current
  current = fibo[-1] + fibo[-2]
end

puts fibo
