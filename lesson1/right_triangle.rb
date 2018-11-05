puts 'Задача - Прямоугольный треугольник'
puts 'Введите длину стороны треугольника A:'
a = gets.chomp.to_i

puts 'Введите длину стороны треугольника B:'
b = gets.chomp.to_i

puts 'Введите длину стороны треугольника C:'
c = gets.chomp.to_i

right = false
isosceles = false
equilateral = false

if a > b && a > c
  right = (b**2 + c**2 == a**2)
  isosceles = (b == c)
elsif b > a && b > c
  right = (a**2 + c**2 == b**2)
  isosceles = (a == c)
elsif c > b && c > a
  right = (a**2 + b**2 == c**2)
  isosceles = (b == a)
else
  isosceles = true
  equilateral = true
end

puts "Прямоугольный: #{right}, равнобедренный: #{isosceles},
      равносторонний: #{equilateral}"
