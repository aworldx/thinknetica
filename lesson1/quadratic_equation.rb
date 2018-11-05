puts 'Задача - Квадратное уравнение'
puts 'Введите коэффициент A:'
a = gets.chomp.to_i

puts 'Введите коэффициент B:'
b = gets.chomp.to_i

puts 'Введите коэффициент C:'
c = gets.chomp.to_i

d = b.abs**2 - 4 * a * c
if d > 0
  x1 = (-b + Math.sqrt(d)) / (2.0 * a)
  x2 = (-b - Math.sqrt(d)) / (2.0 * a)

  puts "D:#{d}, x1: #{x1}, x2: #{x2}"
elsif d.zero?
  x1 = -b / (2.0 * a)

  puts "D:#{d}, x1 = x2: #{x1}"
else
  puts "D:#{d}, Корней нет"
end
